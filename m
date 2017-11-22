Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40862 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbdKVKvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 05:51:44 -0500
Received: by mail-lf0-f65.google.com with SMTP id d10so6633497lfj.7
        for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2017 02:51:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171122103146.GA30667@ulmo>
References: <20171121150116.24956-1-kherbst@redhat.com> <20171121174609.GA28301@ulmo>
 <CACO55tv6J+eY_KNvQxdKShaLi2Td7dDpQa-ety4tgFqvsij34Q@mail.gmail.com> <20171122103146.GA30667@ulmo>
From: Karol Herbst <kherbst@redhat.com>
Date: Wed, 22 Nov 2017 11:51:42 +0100
Message-ID: <CACO55ttqBtLoz+9mE69n1+3sJw5bzaUQN0QL2g45XJQMq_OU9w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] drm: don't continue with anything after the
 GPU couldn't be woken up
To: Thierry Reding <thierry.reding@gmail.com>
Cc: nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 11:31 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Nov 21, 2017 at 08:03:20PM +0100, Karol Herbst wrote:
>> On Tue, Nov 21, 2017 at 6:46 PM, Thierry Reding
>> <thierry.reding@gmail.com> wrote:
>> > On Tue, Nov 21, 2017 at 04:01:16PM +0100, Karol Herbst wrote:
>> >> This should make systems more stable where resuming the GPU fails. This
>> >> can happen due to bad firmware or due to a bug within the kernel. The
>> >> last thing which should happen in either case is an unusable system.
>> >>
>> >> v2: do the same in nouveau_pmops_resume
>> >>
>> >> Tested-by: Karl Hastings <kazen@redhat.com>
>> >> Signed-off-by: Karol Herbst <kherbst@redhat.com>
>> >> ---
>> >>  drm/nouveau/nouveau_drm.c | 31 +++++++++++++++++++++++--------
>> >>  1 file changed, 23 insertions(+), 8 deletions(-)
>> >>
>> >> diff --git a/drm/nouveau/nouveau_drm.c b/drm/nouveau/nouveau_drm.c
>> >> index 8d4a5be3..6e4cb4f7 100644
>> >> --- a/drm/nouveau/nouveau_drm.c
>> >> +++ b/drm/nouveau/nouveau_drm.c
>> >> @@ -792,6 +792,27 @@ nouveau_pmops_suspend(struct device *dev)
>> >>       return 0;
>> >>  }
>> >>
>> >> +static int
>> >> +nouveau_set_power_state_D0(struct pci_dev *pdev)
>> >> +{
>> >> +     struct nouveau_drm *drm = nouveau_drm(pci_get_drvdata(pdev));
>> >> +     int ret;
>> >> +
>> >> +     pci_set_power_state(pdev, PCI_D0);
>> >> +     /* abort if anything went wrong */
>> >> +     if (pdev->current_state != PCI_D0) {
>> >> +             NV_ERROR(drm, "couldn't wake up GPU!\n");
>> >> +             return -EBUSY;
>> >> +     }
>> >
>> > Looks to me like the more idiomatic way to do this is:
>> >
>> >         ret = pci_set_power_state(pdev, PCI_D0);
>> >         if (ret < 0 && ret != -EIO)
>> >                 return ret;
>> >
>>
>> I thought so too, but it ends up returning 0 even if setting the power
>> state fails. Or maybe I did something wrong when installing the
>> kernel. I could take another shot at it, but what I came up with seems
>> to work. Adding airlied in CC, because he saw my patch and didn't
>> complain about it. Hopefully he knows more.
>
> pci_raw_set_power_state(), called by pci_set_power_state(), contains
> this, which looks to me like it would be the only case where the problem
> you're describing could be coming from:
>
>         dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
>         if (dev->current_state != state && printk_ratelimit())
>                 dev_info(&dev->dev, "Refused to change power state, currently in D%d\n",
>                          dev->current_state);
>
> Do you happen to see this in the kernel logs? Perhaps this should be
> considered an error rather than just an KERN_INFO level message?
>
> Adding Bjorn and linux-pci for visibility.
>
> Thierry

yeah, that is the error we have in dmesg.
