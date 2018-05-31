Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36559 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755433AbeEaO1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 10:27:44 -0400
MIME-Version: 1.0
In-Reply-To: <20180531032049.GB15516@debian>
References: <20180530085521.26583-1-tiwei.bie@intel.com> <20180530192010-mutt-send-email-mst@kernel.org>
 <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com> <1527699273.29907.2.camel@intel.com>
 <5063D90B-7955-4F1E-85A2-D8AFD661ACB7@intel.com> <20180531032049.GB15516@debian>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 31 May 2018 07:27:43 -0700
Message-ID: <CAKgT0Ud1QmotAXGOi1ORA79rYLFzofDZWPiJtPj=MBg4zxiSdw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 8:20 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> On Thu, May 31, 2018 at 01:11:37AM +0800, Rustad, Mark D wrote:
>> On May 30, 2018, at 9:54 AM, Duyck, Alexander H
>> <alexander.h.duyck@intel.com> wrote:
>>
>> > On Wed, 2018-05-30 at 09:44 -0700, Rustad, Mark D wrote:
>> > > On May 30, 2018, at 9:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > >
>> > > > > +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int
>> > > > > num_vfs)
>> > > > > +{
>> > > > > +     struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>> > > > > +     struct virtio_device *vdev = &vp_dev->vdev;
>> > > > > +     int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
>> > > > > +
>> > > > > +     if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>> > > > > +             return -EBUSY;
>> > > > > +
>> > > > > +     if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>> > > > > +             return -EINVAL;
>> > > > > +
>> > > > > +     sriov_configure = pci_sriov_configure_simple;
>> > > > > +     if (sriov_configure == NULL)
>> > > > > +             return -ENOENT;
>> > > >
>> > > > BTW what is all this trickery in aid of?
>> > >
>> > > When SR-IOV support is not compiled into the kernel,
>> > > pci_sriov_configure_simple is #defined as NULL. This allows it to compile
>> > > in that case, even though there is utterly no way for it to be called in
>> > > that case. It is an alternative to #ifs in the code.
>> >
>> > Why even have the call though? I would wrap all of this in an #ifdef
>> > and strip it out since you couldn't support SR-IOV if it isn't present
>> > in the kernel anyway.
>>
>> I am inclined to agree. In this case, the presence of #ifdefs I think would
>> be clearer. As written, someone will want to get rid of the pointer only to
>> create a build problem when SR-IOV is not configured.
>
> In my opinion, maybe it would be better to make
> pci_sriov_configure_simple() always available
> just like other sriov functions.
>
> Based on the comments in the original patch:
>
> https://patchwork.kernel.org/patch/10353197/
> """
> +/* this is expected to be used as a function pointer, just define as NULL */
> +#define pci_sriov_configure_simple NULL
> """
>
> This function could be defined as NULL just because
> it was expected to be used as a function pointer.
> But actually it could be called directly as a
> function, just like this case.
>
> So I prefer to make this function always available
> just like other sriov functions.
>
> Best regards,
> Tiwei Bie

The fact that you are having to add additional code kind of implies
that maybe this doesn't fall into the pci_sriov_configure_simple case
anymore. The PF itself is defining what the VF can and can't do via
the feature flags you are testing for.

For example how is the bit of code below valid if the kernel itself
doesn't support SR-IOV:
+static void vp_transport_features(struct virtio_device *vdev, u64 features)
+{
+       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+       struct pci_dev *pci_dev = vp_dev->pci_dev;
+
+       if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
+                       pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
+               __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
+}
+

It really seems like we should be wrapping these functions at the very
minimum so that they don't imply you have SR-IOV support when it isn't
supported in the kernel.

Also it seems like we should be disabling the VFs if the driver is
unbound from this interface. We need to add logic to disable SR-IOV if
the driver is removed. What we don't want to do is leave VFs allocated
and then have the potential for us to unbind/rebind the driver as the
new driver may change the negotiated features.

- Alex
