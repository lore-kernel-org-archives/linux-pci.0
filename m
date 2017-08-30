MIME-Version: 1.0
Reply-To: bjorn@helgaas.com
In-Reply-To: <201708310315.JpbFFzYe%fengguang.wu@intel.com>
References: <201708310315.JpbFFzYe%fengguang.wu@intel.com>
Date: Wed, 30 Aug 2017 15:00:15 -0500
Message-ID: <CABhMZUU+_fQzS0Hchi_aWW1c3faCTr5KbfbS-2ec5ojSJvNPXA@mail.gmail.com>
Subject: Re: [pci:pci/host-vmd 7/7] drivers/iommu/intel-iommu.c:906:7: error:
 implicit declaration of function 'is_vmd'
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>, kbuild-all@01.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: multipart/alternative; boundary="94eb2c128da0f9599d0557fdf96b"
List-ID: <linux-pci.vger.kernel.org>

--94eb2c128da0f9599d0557fdf96b
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 30, 2017 at 2:53 PM, kbuild test robot <fengguang.wu@intel.com>
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
pci/host-vmd
> head:   155f39b4552f5ea5f6d0a4c7d942445369c32b08
> commit: 155f39b4552f5ea5f6d0a4c7d942445369c32b08 [7/7] iommu/vt-d:
Prevent VMD child devices from being remapping targets
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget
https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O
~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 155f39b4552f5ea5f6d0a4c7d942445369c32b08
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64
>
> All errors (new ones prefixed by >>):
>
>    drivers/iommu/intel-iommu.c: In function 'device_to_iommu':
> >> drivers/iommu/intel-iommu.c:906:7: error: implicit declaration of
function 'is_vmd' [-Werror=implicit-function-declaration]
>       if (is_vmd(pdev->bus))
>           ^~~~~~
>    cc1: some warnings being treated as errors

Oops, is_vmd() isn't defined for ia64.  I dropped this last patch for now.

> vim +/is_vmd +906 drivers/iommu/intel-iommu.c
>
>    887
>    888  static struct intel_iommu *device_to_iommu(struct device *dev, u8
*bus, u8 *devfn)
>    889  {
>    890          struct dmar_drhd_unit *drhd = NULL;
>    891          struct intel_iommu *iommu;
>    892          struct device *tmp;
>    893          struct pci_dev *ptmp, *pdev = NULL;
>    894          u16 segment = 0;
>    895          int i;
>    896
>    897          if (iommu_dummy(dev))
>    898                  return NULL;
>    899
>    900          if (dev_is_pci(dev)) {
>    901                  struct pci_dev *pf_pdev;
>    902
>    903                  pdev = to_pci_dev(dev);
>    904
>    905                  /* VMD child devices currently cannot be handled
individually */
>  > 906                  if (is_vmd(pdev->bus))
>    907                          return NULL;
>    908
>    909                  /* VFs aren't listed in scope tables; we need to
look up
>    910                   * the PF instead to find the IOMMU. */
>    911                  pf_pdev = pci_physfn(pdev);
>    912                  dev = &pf_pdev->dev;
>    913                  segment = pci_domain_nr(pdev->bus);
>    914          } else if (has_acpi_companion(dev))
>    915                  dev = &ACPI_COMPANION(dev)->dev;
>    916
>    917          rcu_read_lock();
>    918          for_each_active_iommu(iommu, drhd) {
>    919                  if (pdev && segment != drhd->segment)
>    920                          continue;
>    921
>    922                  for_each_active_dev_scope(drhd->devices,
>    923                                            drhd->devices_cnt, i,
tmp) {
>    924                          if (tmp == dev) {
>    925                                  /* For a VF use its original BDF#
not that of the PF
>    926                                   * which we used for the IOMMU
lookup. Strictly speaking
>    927                                   * we could do this for all PCI
devices; we only need to
>    928                                   * get the BDF# from the scope
table for ACPI matches. */
>    929                                  if (pdev && pdev->is_virtfn)
>    930                                          goto got_pdev;
>    931
>    932                                  *bus = drhd->devices[i].bus;
>    933                                  *devfn = drhd->devices[i].devfn;
>    934                                  goto out;
>    935                          }
>    936
>    937                          if (!pdev || !dev_is_pci(tmp))
>    938                                  continue;
>    939
>    940                          ptmp = to_pci_dev(tmp);
>    941                          if (ptmp->subordinate &&
>    942                              ptmp->subordinate->number <=
pdev->bus->number &&
>    943                              ptmp->subordinate->busn_res.end >=
pdev->bus->number)
>    944                                  goto got_pdev;
>    945                  }
>    946
>    947                  if (pdev && drhd->include_all) {
>    948                  got_pdev:
>    949                          *bus = pdev->bus->number;
>    950                          *devfn = pdev->devfn;
>    951                          goto out;
>    952                  }
>    953          }
>    954          iommu = NULL;
>    955   out:
>    956          rcu_read_unlock();
>    957
>    958          return iommu;
>    959  }
>    960
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
Corporation

--94eb2c128da0f9599d0557fdf96b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj5PbiBXZWQsIEF1ZyAzMCwgMjAxNyBhdCAyOjUzIFBNLCBr
YnVpbGQgdGVzdCByb2JvdCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZlbmdndWFuZy53dUBpbnRlbC5j
b20iPmZlbmdndWFuZy53dUBpbnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+Jmd0Ozxicj4mZ3Q7
IHRyZWU6IMKgIDxhIGhyZWY9Imh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2hlbGdhYXMvcGNpLmdpdCI+aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvaGVsZ2Fhcy9wY2kuZ2l0PC9hPiBwY2kvaG9zdC12bWQ8YnI+Jmd0
OyBoZWFkOiDCoCAxNTVmMzliNDU1MmY1ZWE1ZjZkMGE0YzdkOTQyNDQ1MzY5YzMyYjA4PGJyPiZn
dDsgY29tbWl0OiAxNTVmMzliNDU1MmY1ZWE1ZjZkMGE0YzdkOTQyNDQ1MzY5YzMyYjA4IFs3Lzdd
IGlvbW11L3Z0LWQ6IFByZXZlbnQgVk1EIGNoaWxkIGRldmljZXMgZnJvbSBiZWluZyByZW1hcHBp
bmcgdGFyZ2V0czxicj4mZ3Q7IGNvbmZpZzogaWE2NC1hbGxtb2Rjb25maWcgKGF0dGFjaGVkIGFz
IC5jb25maWcpPGJyPiZndDsgY29tcGlsZXI6IGlhNjQtbGludXgtZ2NjIChHQ0MpIDYuMi4wPGJy
PiZndDsgcmVwcm9kdWNlOjxicj4mZ3Q7IMKgIMKgIMKgIMKgIHdnZXQgPGEgaHJlZj0iaHR0cHM6
Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tLzAxb3JnL2xrcC10ZXN0cy9tYXN0ZXIvc2Jpbi9t
YWtlLmNyb3NzIj5odHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vMDFvcmcvbGtwLXRl
c3RzL21hc3Rlci9zYmluL21ha2UuY3Jvc3M8L2E+IC1PIH4vYmluL21ha2UuY3Jvc3M8YnI+Jmd0
OyDCoCDCoCDCoCDCoCBjaG1vZCAreCB+L2Jpbi9tYWtlLmNyb3NzPGJyPiZndDsgwqAgwqAgwqAg
wqAgZ2l0IGNoZWNrb3V0IDE1NWYzOWI0NTUyZjVlYTVmNmQwYTRjN2Q5NDI0NDUzNjljMzJiMDg8
YnI+Jmd0OyDCoCDCoCDCoCDCoCAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXgg
YnVpbGQgdHJlZTxicj4mZ3Q7IMKgIMKgIMKgIMKgIG1ha2UuY3Jvc3MgQVJDSD1pYTY0PGJyPiZn
dDs8YnI+Jmd0OyBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBieSAmZ3Q7Jmd0Oyk6PGJy
PiZndDs8YnI+Jmd0OyDCoCDCoGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYzogSW4gZnVuY3Rp
b24gJiMzOTtkZXZpY2VfdG9faW9tbXUmIzM5Ozo8YnI+Jmd0OyAmZ3Q7Jmd0OyBkcml2ZXJzL2lv
bW11L2ludGVsLWlvbW11LmM6OTA2Ojc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiAmIzM5O2lzX3ZtZCYjMzk7IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xh
cmF0aW9uXTxicj4mZ3Q7IMKgIMKgIMKgIGlmIChpc192bWQocGRldi0mZ3Q7YnVzKSk8YnI+Jmd0
OyDCoCDCoCDCoCDCoCDCoCBefn5+fn48YnI+Jmd0OyDCoCDCoGNjMTogc29tZSB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9yczxkaXY+PGJyPjwvZGl2PjxkaXY+T29wcywgaXNfdm1kKCkg
aXNuJiMzOTt0IGRlZmluZWQgZm9yIGlhNjQuwqAgSSBkcm9wcGVkIHRoaXMgbGFzdCBwYXRjaCBm
b3Igbm93LjwvZGl2PjxkaXY+PGJyPiZndDsgdmltICsvaXNfdm1kICs5MDYgZHJpdmVycy9pb21t
dS9pbnRlbC1pb21tdS5jPGJyPiZndDs8YnI+Jmd0OyDCoCDCoDg4Nzxicj4mZ3Q7IMKgIMKgODg4
IMKgc3RhdGljIHN0cnVjdCBpbnRlbF9pb21tdSAqZGV2aWNlX3RvX2lvbW11KHN0cnVjdCBkZXZp
Y2UgKmRldiwgdTggKmJ1cywgdTggKmRldmZuKTxicj4mZ3Q7IMKgIMKgODg5IMKgezxicj4mZ3Q7
IMKgIMKgODkwIMKgIMKgIMKgIMKgIMKgc3RydWN0IGRtYXJfZHJoZF91bml0ICpkcmhkID0gTlVM
TDs8YnI+Jmd0OyDCoCDCoDg5MSDCoCDCoCDCoCDCoCDCoHN0cnVjdCBpbnRlbF9pb21tdSAqaW9t
bXU7PGJyPiZndDsgwqAgwqA4OTIgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZGV2aWNlICp0bXA7PGJy
PiZndDsgwqAgwqA4OTMgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcGNpX2RldiAqcHRtcCwgKnBkZXYg
PSBOVUxMOzxicj4mZ3Q7IMKgIMKgODk0IMKgIMKgIMKgIMKgIMKgdTE2IHNlZ21lbnQgPSAwOzxi
cj4mZ3Q7IMKgIMKgODk1IMKgIMKgIMKgIMKgIMKgaW50IGk7PGJyPiZndDsgwqAgwqA4OTY8YnI+
Jmd0OyDCoCDCoDg5NyDCoCDCoCDCoCDCoCDCoGlmIChpb21tdV9kdW1teShkZXYpKTxicj4mZ3Q7
IMKgIMKgODk4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7PGJyPiZndDsg
wqAgwqA4OTk8YnI+Jmd0OyDCoCDCoDkwMCDCoCDCoCDCoCDCoCDCoGlmIChkZXZfaXNfcGNpKGRl
dikpIHs8YnI+Jmd0OyDCoCDCoDkwMSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBw
Y2lfZGV2ICpwZl9wZGV2Ozxicj4mZ3Q7IMKgIMKgOTAyPGJyPiZndDsgwqAgwqA5MDMgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBwZGV2ID0gdG9fcGNpX2RldihkZXYpOzxicj4mZ3Q7IMKgIMKg
OTA0PGJyPiZndDsgwqAgwqA5MDUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBWTUQgY2hp
bGQgZGV2aWNlcyBjdXJyZW50bHkgY2Fubm90IGJlIGhhbmRsZWQgaW5kaXZpZHVhbGx5ICovPGJy
PiZndDsgwqAmZ3Q7IDkwNiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpc192bWQocGRl
di0mZ3Q7YnVzKSk8YnI+Jmd0OyDCoCDCoDkwNyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBOVUxMOzxicj4mZ3Q7IMKgIMKgOTA4PGJyPiZndDsgwqAgwqA5MDkg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBWRnMgYXJlbiYjMzk7dCBsaXN0ZWQgaW4gc2Nv
cGUgdGFibGVzOyB3ZSBuZWVkIHRvIGxvb2sgdXA8YnI+Jmd0OyDCoCDCoDkxMCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqIHRoZSBQRiBpbnN0ZWFkIHRvIGZpbmQgdGhlIElPTU1VLiAqLzxi
cj4mZ3Q7IMKgIMKgOTExIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGZfcGRldiA9IHBjaV9w
aHlzZm4ocGRldik7PGJyPiZndDsgwqAgwqA5MTIgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBk
ZXYgPSAmYW1wO3BmX3BkZXYtJmd0O2Rldjs8YnI+Jmd0OyDCoCDCoDkxMyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHNlZ21lbnQgPSBwY2lfZG9tYWluX25yKHBkZXYtJmd0O2J1cyk7PGJyPiZn
dDsgwqAgwqA5MTQgwqAgwqAgwqAgwqAgwqB9IGVsc2UgaWYgKGhhc19hY3BpX2NvbXBhbmlvbihk
ZXYpKTxicj4mZ3Q7IMKgIMKgOTE1IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2ID0gJmFt
cDtBQ1BJX0NPTVBBTklPTihkZXYpLSZndDtkZXY7PGJyPiZndDsgwqAgwqA5MTY8YnI+Jmd0OyDC
oCDCoDkxNyDCoCDCoCDCoCDCoCDCoHJjdV9yZWFkX2xvY2soKTs8YnI+Jmd0OyDCoCDCoDkxOCDC
oCDCoCDCoCDCoCDCoGZvcl9lYWNoX2FjdGl2ZV9pb21tdShpb21tdSwgZHJoZCkgezxicj4mZ3Q7
IMKgIMKgOTE5IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHBkZXYgJmFtcDsmYW1wOyBz
ZWdtZW50ICE9IGRyaGQtJmd0O3NlZ21lbnQpPGJyPiZndDsgwqAgwqA5MjAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+Jmd0OyDCoCDCoDkyMTxicj4m
Z3Q7IMKgIMKgOTIyIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yX2VhY2hfYWN0aXZlX2Rl
dl9zY29wZShkcmhkLSZndDtkZXZpY2VzLDxicj4mZ3Q7IMKgIMKgOTIzIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZHJoZC0m
Z3Q7ZGV2aWNlc19jbnQsIGksIHRtcCkgezxicj4mZ3Q7IMKgIMKgOTI0IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHRtcCA9PSBkZXYpIHs8YnI+Jmd0OyDCoCDCoDky
NSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIEZv
ciBhIFZGIHVzZSBpdHMgb3JpZ2luYWwgQkRGIyBub3QgdGhhdCBvZiB0aGUgUEY8YnI+Jmd0OyDC
oCDCoDkyNiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAqIHdoaWNoIHdlIHVzZWQgZm9yIHRoZSBJT01NVSBsb29rdXAuIFN0cmljdGx5IHNwZWFraW5n
PGJyPiZndDsgwqAgwqA5MjcgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKiB3ZSBjb3VsZCBkbyB0aGlzIGZvciBhbGwgUENJIGRldmljZXM7IHdlIG9u
bHkgbmVlZCB0bzxicj4mZ3Q7IMKgIMKgOTI4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICogZ2V0IHRoZSBCREYjIGZyb20gdGhlIHNjb3BlIHRhYmxl
IGZvciBBQ1BJIG1hdGNoZXMuICovPGJyPiZndDsgwqAgwqA5MjkgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocGRldiAmYW1wOyZhbXA7IHBkZXYt
Jmd0O2lzX3ZpcnRmbik8YnI+Jmd0OyDCoCDCoDkzMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZ290X3BkZXY7PGJyPiZn
dDsgwqAgwqA5MzE8YnI+Jmd0OyDCoCDCoDkzMiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpidXMgPSBkcmhkLSZndDtkZXZpY2VzW2ldLmJ1czs8YnI+
Jmd0OyDCoCDCoDkzMyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCpkZXZmbiA9IGRyaGQtJmd0O2RldmljZXNbaV0uZGV2Zm47PGJyPiZndDsgwqAgwqA5
MzQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3Rv
IG91dDs8YnI+Jmd0OyDCoCDCoDkzNSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+Jmd0OyDCoCDCoDkzNjxicj4mZ3Q7IMKgIMKgOTM3IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCFwZGV2IHx8ICFkZXZfaXNfcGNpKHRtcCkpPGJyPiZn
dDsgwqAgwqA5MzggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjb250aW51ZTs8YnI+Jmd0OyDCoCDCoDkzOTxicj4mZ3Q7IMKgIMKgOTQwIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcHRtcCA9IHRvX3BjaV9kZXYodG1wKTs8YnI+
Jmd0OyDCoCDCoDk0MSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChw
dG1wLSZndDtzdWJvcmRpbmF0ZSAmYW1wOyZhbXA7PGJyPiZndDsgwqAgwqA5NDIgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwdG1wLSZndDtzdWJvcmRpbmF0ZS0m
Z3Q7bnVtYmVyICZsdDs9IHBkZXYtJmd0O2J1cy0mZ3Q7bnVtYmVyICZhbXA7JmFtcDs8YnI+Jmd0
OyDCoCDCoDk0MyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHB0
bXAtJmd0O3N1Ym9yZGluYXRlLSZndDtidXNuX3Jlcy5lbmQgJmd0Oz0gcGRldi0mZ3Q7YnVzLSZn
dDtudW1iZXIpPGJyPiZndDsgwqAgwqA5NDQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGdvdF9wZGV2Ozxicj4mZ3Q7IMKgIMKgOTQ1IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4mZ3Q7IMKgIMKgOTQ2PGJyPiZndDsgwqAgwqA5NDcg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocGRldiAmYW1wOyZhbXA7IGRyaGQtJmd0O2lu
Y2x1ZGVfYWxsKSB7PGJyPiZndDsgwqAgwqA5NDggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBn
b3RfcGRldjo8YnI+Jmd0OyDCoCDCoDk0OSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCpidXMgPSBwZGV2LSZndDtidXMtJmd0O251bWJlcjs8YnI+Jmd0OyDCoCDCoDk1MCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpkZXZmbiA9IHBkZXYtJmd0O2Rl
dmZuOzxicj4mZ3Q7IMKgIMKgOTUxIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ290byBvdXQ7PGJyPiZndDsgwqAgwqA5NTIgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
PGJyPiZndDsgwqAgwqA5NTMgwqAgwqAgwqAgwqAgwqB9PGJyPiZndDsgwqAgwqA5NTQgwqAgwqAg
wqAgwqAgwqBpb21tdSA9IE5VTEw7PGJyPiZndDsgwqAgwqA5NTUgwqAgb3V0Ojxicj4mZ3Q7IMKg
IMKgOTU2IMKgIMKgIMKgIMKgIMKgcmN1X3JlYWRfdW5sb2NrKCk7PGJyPiZndDsgwqAgwqA5NTc8
YnI+Jmd0OyDCoCDCoDk1OCDCoCDCoCDCoCDCoCDCoHJldHVybiBpb21tdTs8YnI+Jmd0OyDCoCDC
oDk1OSDCoH08YnI+Jmd0OyDCoCDCoDk2MDxicj4mZ3Q7PGJyPiZndDsgLS0tPGJyPiZndDsgMC1E
QVkga2VybmVsIHRlc3QgaW5mcmFzdHJ1Y3R1cmUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBPcGVu
IFNvdXJjZSBUZWNobm9sb2d5IENlbnRlcjxicj4mZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMu
MDEub3JnL3BpcGVybWFpbC9rYnVpbGQtYWxsIj5odHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1h
aWwva2J1aWxkLWFsbDwvYT4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSW50ZWwgQ29ycG9y
YXRpb248L2Rpdj48L2Rpdj4NCg==
--94eb2c128da0f9599d0557fdf96b--
