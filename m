Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60062 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab2JBUBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 16:01:37 -0400
Received: by bkcjk13 with SMTP id jk13so5727076bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 13:01:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
Date: Tue, 2 Oct 2012 13:01:32 -0700
Message-ID: <CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
From: Yinghai Lu <yinghai@kernel.org>
To: Donald Dutile <ddutile@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Content-Type: multipart/mixed; boundary=0015175d04423ea04304cb18fd6b
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--0015175d04423ea04304cb18fd6b
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 1, 2012 at 4:27 PM, Donald Dutile <ddutile@redhat.com> wrote:
> Provide files under sysfs to determine the max number of vfs
> an SRIOV-capable PCIe device supports, and methods to enable and
> disable the vfs on a per device basis.
>
> Currently, VF enablement by SRIOV-capable PCIe devices is done
> in driver-specific module parameters.  If not setup in modprobe files,
> it requires admin to unload & reload PF drivers with number of desired
> VFs to enable.  Additionally, the enablement is system wide: all
> devices controlled by the same driver have the same number of VFs
> enabled.  Although the latter is probably desired, there are PCI
> configurations setup by system BIOS that may not enable that to occur.
>
> Three files are created if a PCIe device has SRIOV support:
> sriov_max_vfs -- cat-ing this file returns the maximum number
>                  of VFs a PCIe device supports.
> sriov_enable_vfs -- echo'ing a number to this file enables this
>                     number of VFs for this given PCIe device.
>                  -- cat-ing this file will return the number of VFs
>                     currently enabled on this PCIe device.
> sriov_disable_vfs -- echo-ing any number other than 0 disables all
>                      VFs associated with this PCIe device.
>
> VF enable and disablement is invoked much like other PCIe
> configuration functions -- via registered callbacks in the driver,
> i.e., probe, release, etc.
>
> Note: I haven't had a chance to refactor an SRIOV PF driver
>       to test against; hoping to try ixgbe or igb in next couple days.
>       To date, just tested that cat-ing sriov_max_vfs works, and
>       cat-ing sriov_enable_vfs returns the correct number when
>       a PF driver has been loaded with VFs enabled via per-driver param,
>       e.g., modprobe igb max_vfs=4
>
> Send comments and I'll integrate as needed, while modifying
> a PF driver to use this interface.
>
> Signed-off-by: Donald Dutile <ddutile@redhat.com>
>
> ---
>  drivers/pci/pci-sysfs.c | 186 ++++++++++++++++++++++++++++++++++++++++++++----
>  include/linux/pci.h     |   2 +
>  2 files changed, 175 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6869009..1b5eab7 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -404,6 +404,152 @@ static ssize_t d3cold_allowed_show(struct device *dev,
>  }
>  #endif
>
> +
> +#ifdef CONFIG_PCI_IOV
> +static ssize_t sriov_max_vfs_show(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 char *buf)
> +{
> +       struct pci_dev *pdev;
> +
> +       pdev = to_pci_dev(dev);
> +       return sprintf (buf, "%u\n", pdev->sriov->total);
> +}
> +
> +bool pci_dev_has_sriov(struct pci_dev *pdev)
> +{
> +       int ret = false;
> +       int pos;
> +
> +        if (!pci_is_pcie(pdev))
> +               goto out;
> +
> +       pos =  pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> +       if (pos)
> +               ret = true;
> +out:
> +       return ret;
> +}
> +
> +static ssize_t sriov_enable_vfs_show(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct pci_dev *pdev;
> +       int nr_virtfn = 0;
> +
> +       pdev = to_pci_dev(dev);
> +
> +       if (pci_dev_has_sriov(pdev))
> +               nr_virtfn = pdev->sriov->nr_virtfn;
> +
> +       return sprintf (buf, "%u\n", nr_virtfn);
> +}
> +
> +static ssize_t sriov_enable_vfs_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t count)
> +{
> +       struct pci_dev *pdev;
> +       int num_vf_enabled = 0;
> +       unsigned long num_vfs;
> +       pdev = to_pci_dev(dev);
> +
> +       if (!pci_dev_has_sriov(pdev))
> +               goto out;
> +
> +       /* Requested VFs to enable < max_vfs
> +        * and none enabled already
> +        */
> +       if (strict_strtoul(buf, 0, &num_vfs) < 0)
> +                       return -EINVAL;
> +
> +       if ((num_vfs > pdev->sriov->total) ||
> +           (pdev->sriov->nr_virtfn != 0))
> +               return -EINVAL;
> +
> +       /* Ready for lift-off! */
> +       if (pdev->driver && pdev->driver->sriov_enable) {
> +               num_vf_enabled = pdev->driver->sriov_enable(pdev, num_vfs);
> +       }
> +
> +out:
> +       if (num_vf_enabled != num_vfs)
> +               printk(KERN_WARNING
> +                       "%s: %04x:%02x:%02x.%d: Only %d VFs enabled \n",
> +                       pci_name(pdev), pci_domain_nr(pdev->bus),
> +                       pdev->bus->number, PCI_SLOT(pdev->devfn),
> +                       PCI_FUNC(pdev->devfn), num_vf_enabled);
> +
> +       return count;
> +}
> +
> +static ssize_t sriov_disable_vfs_store(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      const char *buf, size_t count)
> +{
> +       struct pci_dev *pdev;
> +
> +       pdev = to_pci_dev(dev);
> +
> +       /* make sure sriov device & at least 1 vf enabled */
> +       if (!pci_dev_has_sriov(pdev) ||
> +          (pdev->sriov->nr_virtfn == 0))
> +               goto out;
> +
> +       /* Ready for landing! */
> +       if (pdev->driver && pdev->driver->sriov_disable) {
> +               pdev->driver->sriov_disable(pdev);
> +       }
> +out:
> +       return count;
> +}
> +
> +struct device_attribute pci_dev_sriov_attrs[] = {
> +       __ATTR_RO(sriov_max_vfs),
> +       __ATTR(sriov_enable_vfs, (S_IRUGO|S_IWUSR|S_IWGRP),
> +               sriov_enable_vfs_show, sriov_enable_vfs_store),
> +       __ATTR(sriov_disable_vfs, (S_IWUSR|S_IWGRP),
> +               NULL, sriov_disable_vfs_store),
> +       __ATTR_NULL,
> +};
> +
> +static int pci_sriov_create_sysfs_dev_files(struct pci_dev *dev)
> +{
> +       int pos, i;
> +       int retval=0;
> +
> +       if ((dev->is_physfn) && pci_is_pcie(dev)) {
> +            pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> +            if (pos) {
> +               for (i = 0; attr_name(pci_dev_sriov_attrs[i]); i++) {
> +                   retval = device_create_file(&dev->dev, &pci_dev_sriov_attrs[i]);
> +                   if (retval) {
> +                       while (--i >= 0)
> +                            device_remove_file(&dev->dev, &pci_dev_sriov_attrs[i]);
> +                       break;
> +                   }
> +               }
> +           }
> +       }
> +       return retval;

> +}
> +
> +static void pci_sriov_remove_sysfs_dev_files(struct pci_dev *dev)
> +{
> +       int pos;
> +
> +       if ((dev->is_physfn) && pci_is_pcie(dev)) {
> +            pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> +            if (pos)
> +               device_remove_file(&dev->dev, pci_dev_sriov_attrs);
> +       }
> +}
...
> @@ -1203,14 +1365,18 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>                         goto error;
>                 dev->reset_fn = 1;
>         }
> +
> +       /* SRIOV */
> +       retval = pci_sriov_create_sysfs_dev_files(dev);
> +       if (retval)
> +               goto error;
> +

No, You should not use function for that.

According to Greg, you should use group visible to do that.

Please check the patches  that i send out before.

here I attached them again.

Yinghai

--0015175d04423ea04304cb18fd6b
Content-Type: application/octet-stream; name="pci_dev_type.patch"
Content-Disposition: attachment; filename="pci_dev_type.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7tfke130

U3ViamVjdDogW1BBVENIXSBQQ0k6IEFkZCBwY2lfZGV2X3R5cGUKCmxhdGVyIHVzZSBpdCBmb3Ig
dmlzaWFibGUgYXR0cmlidXRlIGNvbnRyb2wuCgpTaWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1IDx5
aW5naGFpQGtlcm5lbC5vcmc+CgotLS0KIGRyaXZlcnMvcGNpL3BjaS1zeXNmcy5jIHwgICAyNCAr
KysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvcGNpL3BjaS5oICAgICAgIHwgICAgMSAr
CiBkcml2ZXJzL3BjaS9wcm9iZS5jICAgICB8ICAgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCAyNiBp
bnNlcnRpb25zKCspCgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNpL3BjaS1zeXNmcy5jCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3BjaS1zeXNmcy5jCisrKyBs
aW51eC0yLjYvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMKQEAgLTE0MDksMyArMTQwOSwyNyBAQCBz
dGF0aWMgaW50IF9faW5pdCBwY2lfc3lzZnNfaW5pdCh2b2lkKQogfQogCiBsYXRlX2luaXRjYWxs
KHBjaV9zeXNmc19pbml0KTsKKworc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnBjaV9kZXZfZGV2
X2F0dHJzW10gPSB7CisJTlVMTCwKK307CisKK3N0YXRpYyB1bW9kZV90IHBjaV9kZXZfYXR0cnNf
YXJlX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosCisJCQkJCQlzdHJ1Y3QgYXR0cmlidXRl
ICphLCBpbnQgbikKK3sKKwlyZXR1cm4gYS0+bW9kZTsKK30KKworc3RhdGljIHN0cnVjdCBhdHRy
aWJ1dGVfZ3JvdXAgcGNpX2Rldl9hdHRyX2dyb3VwID0geworCS5hdHRycyA9IHBjaV9kZXZfZGV2
X2F0dHJzLAorCS5pc192aXNpYmxlID0gcGNpX2Rldl9hdHRyc19hcmVfdmlzaWJsZSwKK307CisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwICpwY2lfZGV2X2F0dHJfZ3JvdXBz
W10gPSB7CisJJnBjaV9kZXZfYXR0cl9ncm91cCwKKwlOVUxMLAorfTsKKworc3RydWN0IGRldmlj
ZV90eXBlIHBjaV9kZXZfdHlwZSA9IHsKKwkuZ3JvdXBzID0gcGNpX2Rldl9hdHRyX2dyb3VwcywK
K307CkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9wY2kvcGNpLmgKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGlu
dXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvcGNpLmgKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9w
Y2kuaApAQCAtMTU4LDYgKzE1OCw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHBjaV9ub19kMWQyKHN0
cnVjdCBwY2kKIH0KIGV4dGVybiBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBwY2lfZGV2X2F0dHJz
W107CiBleHRlcm4gc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgcGNpYnVzX2Rldl9hdHRyc1tdOwor
ZXh0ZXJuIHN0cnVjdCBkZXZpY2VfdHlwZSBwY2lfZGV2X3R5cGU7CiAjaWZkZWYgQ09ORklHX0hP
VFBMVUcKIGV4dGVybiBzdHJ1Y3QgYnVzX2F0dHJpYnV0ZSBwY2lfYnVzX2F0dHJzW107CiAjZWxz
ZQpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNpL3Byb2JlLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGlu
dXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvcHJvYmUuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNp
L3Byb2JlLmMKQEAgLTEyNzQsNiArMTI3NCw3IEBAIGludCBwY2lfc2V0dXBfZGV2aWNlKHN0cnVj
dCBwY2lfZGV2ICpkZXYKIAlkZXYtPnN5c2RhdGEgPSBkZXYtPmJ1cy0+c3lzZGF0YTsKIAlkZXYt
PmRldi5wYXJlbnQgPSBkZXYtPmJ1cy0+YnJpZGdlOwogCWRldi0+ZGV2LmJ1cyA9ICZwY2lfYnVz
X3R5cGU7CisJZGV2LT5kZXYudHlwZSA9ICZwY2lfZGV2X3R5cGU7CiAJZGV2LT5oZHJfdHlwZSA9
IGhkcl90eXBlICYgMHg3ZjsKIAlkZXYtPm11bHRpZnVuY3Rpb24gPSAhIShoZHJfdHlwZSAmIDB4
ODApOwogCWRldi0+ZXJyb3Jfc3RhdGUgPSBwY2lfY2hhbm5lbF9pb19ub3JtYWw7Cg==
--0015175d04423ea04304cb18fd6b
Content-Type: application/octet-stream;
	name="pci_010_pci_dev_boot_vga_x.patch"
Content-Disposition: attachment; filename="pci_010_pci_dev_boot_vga_x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7tfksnh1

U3ViamVjdDogW1BBVENIIDEwLzEwXSBQQ0ksIHN5czogVXNlIGlzX3Zpc2FibGUoKSB3aXRoIGJv
b3RfdmdhIGF0dHJpYnV0ZSBmb3IgcGNpX2RldgoKVGhhdCBjb3VsZCBsZXQgcGNpX2NyZWF0ZV9z
eXNmc19kZXZfZmlsZXMgbW9yZSBzaW1wbGUuCgphbHNvIGZpeCBwb3NzaWJsZSBmaXggbWVtbGVh
ayBkdXJpbmcgcmVtb3ZpbmcgcGF0aC4KClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdo
YWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMgfCAgIDIxICsrKysr
KysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9wY2ktc3lzZnMuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9wY2ktc3lzZnMuYworKysgbGlu
dXgtMi42L2RyaXZlcnMvcGNpL3BjaS1zeXNmcy5jCkBAIC0xMzAxLDI5ICsxMzAxLDIwIEBAIGlu
dCBfX211c3RfY2hlY2sgcGNpX2NyZWF0ZV9zeXNmc19kZXZfZmkKIAkJcGRldi0+cm9tX2F0dHIg
PSBhdHRyOwogCX0KIAotCWlmICgocGRldi0+Y2xhc3MgPj4gOCkgPT0gUENJX0NMQVNTX0RJU1BM
QVlfVkdBKSB7Ci0JCXJldHZhbCA9IGRldmljZV9jcmVhdGVfZmlsZSgmcGRldi0+ZGV2LCAmdmdh
X2F0dHIpOwotCQlpZiAocmV0dmFsKQotCQkJZ290byBlcnJfcm9tX2ZpbGU7Ci0JfQotCiAJLyog
YWRkIHBsYXRmb3JtLXNwZWNpZmljIGF0dHJpYnV0ZXMgKi8KIAlyZXR2YWwgPSBwY2liaW9zX2Fk
ZF9wbGF0Zm9ybV9lbnRyaWVzKHBkZXYpOwogCWlmIChyZXR2YWwpCi0JCWdvdG8gZXJyX3ZnYV9m
aWxlOworCQlnb3RvIGVycl9yb21fZmlsZTsKIAogCS8qIGFkZCBzeXNmcyBlbnRyaWVzIGZvciB2
YXJpb3VzIGNhcGFiaWxpdGllcyAqLwogCXJldHZhbCA9IHBjaV9jcmVhdGVfY2FwYWJpbGl0aWVz
X3N5c2ZzKHBkZXYpOwogCWlmIChyZXR2YWwpCi0JCWdvdG8gZXJyX3ZnYV9maWxlOworCQlnb3Rv
IGVycl9yb21fZmlsZTsKIAogCXBjaV9jcmVhdGVfZmlybXdhcmVfbGFiZWxfZmlsZXMocGRldik7
CiAKIAlyZXR1cm4gMDsKIAotZXJyX3ZnYV9maWxlOgotCWlmICgocGRldi0+Y2xhc3MgPj4gOCkg
PT0gUENJX0NMQVNTX0RJU1BMQVlfVkdBKQotCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoJnBkZXYtPmRl
diwgJnZnYV9hdHRyKTsKIGVycl9yb21fZmlsZToKIAlpZiAocm9tX3NpemUpIHsKIAkJc3lzZnNf
cmVtb3ZlX2Jpbl9maWxlKCZwZGV2LT5kZXYua29iaiwgcGRldi0+cm9tX2F0dHIpOwpAQCAtMTQx
MSwxMiArMTQwMiwyMCBAQCBzdGF0aWMgaW50IF9faW5pdCBwY2lfc3lzZnNfaW5pdCh2b2lkKQog
bGF0ZV9pbml0Y2FsbChwY2lfc3lzZnNfaW5pdCk7CiAKIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
ICpwY2lfZGV2X2Rldl9hdHRyc1tdID0geworCSZ2Z2FfYXR0ci5hdHRyLAogCU5VTEwsCiB9Owog
CiBzdGF0aWMgdW1vZGVfdCBwY2lfZGV2X2F0dHJzX2FyZV92aXNpYmxlKHN0cnVjdCBrb2JqZWN0
ICprb2JqLAogCQkJCQkJc3RydWN0IGF0dHJpYnV0ZSAqYSwgaW50IG4pCiB7CisJc3RydWN0IGRl
dmljZSAqZGV2ID0gY29udGFpbmVyX29mKGtvYmosIHN0cnVjdCBkZXZpY2UsIGtvYmopOworCXN0
cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOworCisJaWYgKGEgPT0gJnZnYV9h
dHRyLmF0dHIpCisJCWlmICgocGRldi0+Y2xhc3MgPj4gOCkgIT0gUENJX0NMQVNTX0RJU1BMQVlf
VkdBKQorCQkJcmV0dXJuIDA7CisKIAlyZXR1cm4gYS0+bW9kZTsKIH0KIAo=
--0015175d04423ea04304cb18fd6b
Content-Type: application/octet-stream; name="pci_drv_set_max_vfs.patch"
Content-Disposition: attachment; filename="pci_drv_set_max_vfs.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7tflby72

LS0tCiBpbmNsdWRlL2xpbnV4L3BjaS5oIHwgICAgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykKCkluZGV4OiBsaW51eC0yLjYvaW5jbHVkZS9saW51eC9wY2kuaAo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSBsaW51eC0yLjYub3JpZy9pbmNsdWRlL2xpbnV4L3BjaS5oCisrKyBsaW51eC0yLjYvaW5j
bHVkZS9saW51eC9wY2kuaApAQCAtNjY1LDYgKzY2NSw3IEBAIHN0cnVjdCBwY2lfZHJpdmVyIHsK
IAljb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWRfdGFibGU7CS8qIG11c3QgYmUgbm9uLU5V
TEwgZm9yIHByb2JlIHRvIGJlIGNhbGxlZCAqLwogCWludCAgKCpwcm9iZSkgIChzdHJ1Y3QgcGNp
X2RldiAqZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpOwkvKiBOZXcgZGV2aWNl
IGluc2VydGVkICovCiAJdm9pZCAoKnJlbW92ZSkgKHN0cnVjdCBwY2lfZGV2ICpkZXYpOwkvKiBE
ZXZpY2UgcmVtb3ZlZCAoTlVMTCBpZiBub3QgYSBob3QtcGx1ZyBjYXBhYmxlIGRyaXZlcikgKi8K
Kwl2b2lkICgqc2V0X21heF92ZnMpIChzdHJ1Y3QgcGNpX2RldiAqZGV2KTsgLyogZW5hYmxlIHNy
aW92ICovCiAJaW50ICAoKnN1c3BlbmQpIChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwbV9tZXNzYWdl
X3Qgc3RhdGUpOwkvKiBEZXZpY2Ugc3VzcGVuZGVkICovCiAJaW50ICAoKnN1c3BlbmRfbGF0ZSkg
KHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSk7CiAJaW50ICAoKnJlc3Vt
ZV9lYXJseSkgKHN0cnVjdCBwY2lfZGV2ICpkZXYpOwo=
--0015175d04423ea04304cb18fd6b
Content-Type: application/octet-stream; name="sriov_xxx.patch"
Content-Disposition: attachment; filename="sriov_xxx.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7tfljnu3

U3ViamVjdDogW1BBVENIXSBQQ0k6IEFkZCBtYXhfdmZzIGluIHN5c2ZzIHBlciBwY2kgZGV2aWNl
IHdoZXJlIHN1cHBvcnRzCgpkcml2ZXIgbGF0ZXIgbmVlZCB0byBjaGVjayBkZXYtPm1heF92ZnMg
aW4gL3N5cwoKU2lnbmVkLW9mZi1ieTogWWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoK
LS0tCiBkcml2ZXJzL3BjaS9wY2ktc3lzZnMuYyB8ICAgNTEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICB8ICAg
IDEgCiAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKykKCkluZGV4OiBsaW51eC0yLjYv
ZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJp
dmVycy9wY2kvcGNpLXN5c2ZzLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9wY2ktc3lzZnMu
YwpAQCAtNDU2LDYgKzQ1Niw1MiBAQCBib290X3ZnYV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0CiB9CiBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSB2Z2FfYXR0ciA9IF9fQVRUUl9STyhi
b290X3ZnYSk7CiAKK3N0YXRpYyBzc2l6ZV90CittYXhfdmZzX3Nob3coc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQoreworCXN0cnVj
dCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOworCisJcmV0dXJuIHNwcmludGYoYnVm
LCAiJXVcbiIsIHBkZXYtPm1heF92ZnMpOworfQorCitzdGF0aWMgdm9pZCBtYXhfdmZzX2NhbGxi
YWNrKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3Bj
aV9kZXYoZGV2KTsKKworCW11dGV4X2xvY2soJnBjaV9yZW1vdmVfcmVzY2FuX211dGV4KTsKKwlp
ZiAocGRldi0+aXNfYWRkZWQgJiYgZGV2LT5kcml2ZXIpeworCQlzdHJ1Y3QgcGNpX2RyaXZlciAq
cGRydjsKKworCQlwZHJ2ID0gdG9fcGNpX2RyaXZlcihkZXYtPmRyaXZlcik7CisJCWlmIChwZHJ2
LT5zZXRfbWF4X3ZmcykKKwkJCXBkcnYtPnNldF9tYXhfdmZzKHBkZXYpOworCisJfQorCW11dGV4
X3VubG9jaygmcGNpX3JlbW92ZV9yZXNjYW5fbXV0ZXgpOworfQorc3RhdGljIHNzaXplX3QKK21h
eF92ZnNfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAq
YXR0ciwKKwkJIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQoreworCXVuc2lnbmVkIGxv
bmcgdmFsOworCWludCBlcnI7CisJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRl
dik7CisKKwlpZiAoc3RyaWN0X3N0cnRvdWwoYnVmLCAwLCAmdmFsKSA8IDApCisJCXJldHVybiAt
RUlOVkFMOworCisJcGRldi0+bWF4X3ZmcyA9IHZhbDsKKworCWVyciA9IGRldmljZV9zY2hlZHVs
ZV9jYWxsYmFjayhkZXYsIG1heF92ZnNfY2FsbGJhY2spOworCisJaWYgKGVycikKKwkJcmV0dXJu
IGVycjsKKworCXJldHVybiBjb3VudDsKK30KK3N0cnVjdCBkZXZpY2VfYXR0cmlidXRlIG1heF92
ZnNfYXR0ciA9CisJX19BVFRSKG1heF92ZnMsIDA2NDQsIG1heF92ZnNfc2hvdywgbWF4X3Zmc19z
dG9yZSk7CisKIHN0YXRpYyB2b2lkCiBwY2lfY29uZmlnX3BtX3J1bnRpbWVfZ2V0KHN0cnVjdCBw
Y2lfZGV2ICpwZGV2KQogewpAQCAtMTQwMyw2ICsxNDQ5LDcgQEAgbGF0ZV9pbml0Y2FsbChwY2lf
c3lzZnNfaW5pdCk7CiAKIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpwY2lfZGV2X2Rldl9hdHRy
c1tdID0gewogCSZ2Z2FfYXR0ci5hdHRyLAorCSZtYXhfdmZzX2F0dHIuYXR0ciwKIAlOVUxMLAog
fTsKIApAQCAtMTQxNiw2ICsxNDYzLDEwIEBAIHN0YXRpYyB1bW9kZV90IHBjaV9kZXZfYXR0cnNf
YXJlX3Zpc2libGUKIAkJaWYgKChwZGV2LT5jbGFzcyA+PiA4KSAhPSBQQ0lfQ0xBU1NfRElTUExB
WV9WR0EpCiAJCQlyZXR1cm4gMDsKIAorCWlmIChhID09ICZtYXhfdmZzX2F0dHIuYXR0cikKKwkJ
aWYgKCFwZGV2LT5pc19waHlzZm4pCisJCQlyZXR1cm4gMDsKKwogCXJldHVybiBhLT5tb2RlOwog
fQogCkluZGV4OiBsaW51eC0yLjYvaW5jbHVkZS9saW51eC9wY2kuaAo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBs
aW51eC0yLjYub3JpZy9pbmNsdWRlL2xpbnV4L3BjaS5oCisrKyBsaW51eC0yLjYvaW5jbHVkZS9s
aW51eC9wY2kuaApAQCAtMzU5LDYgKzM1OSw3IEBAIHN0cnVjdCBwY2lfZGV2IHsKIAl1bnNpZ25l
ZCBpbnQJYnJva2VuX2ludHhfbWFza2luZzoxOwogCXVuc2lnbmVkIGludAlpb193aW5kb3dfMWs6
MTsJLyogSW50ZWwgUDJQIGJyaWRnZSAxSyBJL08gd2luZG93cyAqLwogCXBjaV9kZXZfZmxhZ3Nf
dCBkZXZfZmxhZ3M7CisJdW5zaWduZWQgaW50CW1heF92ZnM7CiAJYXRvbWljX3QJZW5hYmxlX2Nu
dDsJLyogcGNpX2VuYWJsZV9kZXZpY2UgaGFzIGJlZW4gY2FsbGVkICovCiAKIAl1MzIJCXNhdmVk
X2NvbmZpZ19zcGFjZVsxNl07IC8qIGNvbmZpZyBzcGFjZSBzYXZlZCBhdCBzdXNwZW5kIHRpbWUg
Ki8K
--0015175d04423ea04304cb18fd6b
Content-Type: application/octet-stream; name="ixgbe_max_vfs.patch"
Content-Disposition: attachment; filename="ixgbe_max_vfs.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7tflui24

LS0tCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZS5oICAgICAgfCAgICAy
ICsKIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX21haW4uYyB8ICAgNDQg
KysrKysrKysrKysrKysrKysrKystLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkKCkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaXhnYmUvaXhnYmVfbWFpbi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmln
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX21haW4uYworKysgbGludXgt
Mi42L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX21haW4uYwpAQCAtMTI5
LDEzICsxMjksNiBAQCBzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIGRjYV9ub3RpZmllCiB9
OwogI2VuZGlmCiAKLSNpZmRlZiBDT05GSUdfUENJX0lPVgotc3RhdGljIHVuc2lnbmVkIGludCBt
YXhfdmZzOwotbW9kdWxlX3BhcmFtKG1heF92ZnMsIHVpbnQsIDApOwotTU9EVUxFX1BBUk1fREVT
QyhtYXhfdmZzLAotCQkgIk1heGltdW0gbnVtYmVyIG9mIHZpcnR1YWwgZnVuY3Rpb25zIHRvIGFs
bG9jYXRlIHBlciBwaHlzaWNhbCBmdW5jdGlvbiAtIGRlZmF1bHQgaXMgemVybyBhbmQgbWF4aW11
bSB2YWx1ZSBpcyA2MyIpOwotI2VuZGlmIC8qIENPTkZJR19QQ0lfSU9WICovCi0KIHN0YXRpYyB1
bnNpZ25lZCBpbnQgYWxsb3dfdW5zdXBwb3J0ZWRfc2ZwOwogbW9kdWxlX3BhcmFtKGFsbG93X3Vu
c3VwcG9ydGVkX3NmcCwgdWludCwgMCk7CiBNT0RVTEVfUEFSTV9ERVNDKGFsbG93X3Vuc3VwcG9y
dGVkX3NmcCwKQEAgLTQ0OTYsNyArNDQ4OSw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGl4Z2Jl
X3N3X2luaXQoc3RydWMKICNpZmRlZiBDT05GSUdfUENJX0lPVgogCS8qIGFzc2lnbiBudW1iZXIg
b2YgU1ItSU9WIFZGcyAqLwogCWlmIChody0+bWFjLnR5cGUgIT0gaXhnYmVfbWFjXzgyNTk4RUIp
Ci0JCWFkYXB0ZXItPm51bV92ZnMgPSAobWF4X3ZmcyA+IDYzKSA/IDAgOiBtYXhfdmZzOworCQlh
ZGFwdGVyLT5udW1fdmZzID0gbWluX3QoaW50LCBwZGV2LT5tYXhfdmZzLCA2Myk7CiAKICNlbmRp
ZgogCS8qIGVuYWJsZSBpdHIgYnkgZGVmYXVsdCBpbiBkeW5hbWljIG1vZGUgKi8KQEAgLTcyMjAs
OCArNzIxMyw5IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGl4Z2JlX3Byb2JlKHN0cnVjdAogCiAj
aWZkZWYgQ09ORklHX1BDSV9JT1YKIAlpeGdiZV9lbmFibGVfc3Jpb3YoYWRhcHRlciwgaWkpOwot
CiAjZW5kaWYKKwlhZGFwdGVyLT5peGdiZV9pbmZvID0gaWk7CisKIAluZXRkZXYtPmZlYXR1cmVz
ID0gTkVUSUZfRl9TRyB8CiAJCQkgICBORVRJRl9GX0lQX0NTVU0gfAogCQkJICAgTkVUSUZfRl9J
UFY2X0NTVU0gfApAQCAtNzY4MywxMSArNzY3Nyw0MyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBj
aV9lcnJvcl9oYW5kbGVycyBpCiAJLnJlc3VtZSA9IGl4Z2JlX2lvX3Jlc3VtZSwKIH07CiAKK3N0
YXRpYyB2b2lkIGl4Z2JlX3NldF9tYXhfdmZzKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworI2lm
ZGVmIENPTkZJR19QQ0lfSU9WCisJc3RydWN0IGl4Z2JlX2FkYXB0ZXIgKmFkYXB0ZXIgPSBwY2lf
Z2V0X2RydmRhdGEocGRldik7CisJc3RydWN0IGl4Z2JlX2h3ICpodyA9ICZhZGFwdGVyLT5odzsK
KwlpbnQgbnVtX3ZmcyA9IDA7CisKKwkvKiBhc3NpZ24gbnVtYmVyIG9mIFNSLUlPViBWRnMgKi8K
KwlpZiAoaHctPm1hYy50eXBlICE9IGl4Z2JlX21hY184MjU5OEVCKQorCQludW1fdmZzID0gbWlu
X3QoaW50LCBwZGV2LT5tYXhfdmZzLCA2Myk7CisKKwkvKiBubyBjaGFuZ2UgKi8KKwlpZiAoYWRh
cHRlci0+bnVtX3ZmcyA9PSBudW1fdmZzKQorCQlyZXR1cm47CisKKwlpZiAoIW51bV92ZnMpIHsK
KwkJLyogZGlzYWJsZSBzcmlvdiAqLworCQlpeGdiZV9kaXNhYmxlX3NyaW92KGFkYXB0ZXIpOwor
CQlhZGFwdGVyLT5udW1fdmZzID0gMDsKKwl9IGVsc2UgaWYgKCFhZGFwdGVyLT5udW1fdmZzICYm
IG51bV92ZnMpIHsKKwkJLyogZW5hYmxlIHNyaW92ICovCisJCWFkYXB0ZXItPm51bV92ZnMgPSBu
dW1fdmZzOworCQlpeGdiZV9lbmFibGVfc3Jpb3YoYWRhcHRlciwgYWRhcHRlci0+aXhnYmVfaW5m
byk7CisJfSBlbHNlIHsKKwkJLyogaW5jcmVhc2Ugb3IgZGVjcmVhc2UgKi8KKwl9CisKKwlwZGV2
LT5tYXhfdmZzID0gYWRhcHRlci0+bnVtX3ZmczsKKyNlbmRpZgorfQorCiBzdGF0aWMgc3RydWN0
IHBjaV9kcml2ZXIgaXhnYmVfZHJpdmVyID0gewogCS5uYW1lICAgICA9IGl4Z2JlX2RyaXZlcl9u
YW1lLAogCS5pZF90YWJsZSA9IGl4Z2JlX3BjaV90YmwsCiAJLnByb2JlICAgID0gaXhnYmVfcHJv
YmUsCiAJLnJlbW92ZSAgID0gX19kZXZleGl0X3AoaXhnYmVfcmVtb3ZlKSwKKwkuc2V0X21heF92
ZnMgPSBpeGdiZV9zZXRfbWF4X3ZmcywKICNpZmRlZiBDT05GSUdfUE0KIAkuc3VzcGVuZCAgPSBp
eGdiZV9zdXNwZW5kLAogCS5yZXN1bWUgICA9IGl4Z2JlX3Jlc3VtZSwKSW5kZXg6IGxpbnV4LTIu
Ni9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZS5oCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlLmgK
KysrIGxpbnV4LTIuNi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZS5oCkBA
IC01NTgsNiArNTU4LDggQEAgc3RydWN0IGl4Z2JlX2FkYXB0ZXIgewogCXUzMiBpbnRlcnJ1cHRf
ZXZlbnQ7CiAJdTMyIGxlZF9yZWc7CiAKKwlzdHJ1Y3QgaXhnYmVfaW5mbyAqaXhnYmVfaW5mbzsK
KwogI2lmZGVmIENPTkZJR19JWEdCRV9QVFAKIAlzdHJ1Y3QgcHRwX2Nsb2NrICpwdHBfY2xvY2s7
CiAJc3RydWN0IHB0cF9jbG9ja19pbmZvIHB0cF9jYXBzOwo=
--0015175d04423ea04304cb18fd6b--
