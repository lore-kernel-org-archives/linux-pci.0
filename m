Return-Path: <SRS0=WgwQ=JU=gmail.com=kernelfans@kernel.org>
Return-Path: <SRS0=WgwQ=JU=gmail.com=kernelfans@kernel.org>
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-4-git-send-email-kernelfans@gmail.com> <3375966.ydPZj5TMVj@aspire.rjw.lan>
In-Reply-To: <3375966.ydPZj5TMVj@aspire.rjw.lan>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 4 Jul 2018 12:40:09 +0800
Message-ID: <CAFgQCTtu7jaUfWV4xq8CfWb7vuS5=+HuNpNxeMm9UawoUZ2CBg@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] drivers/base: clean up the usage of devices_kset_move_last()
To: rjw@rjwysocki.net
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 3, 2018 at 10:28 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, July 3, 2018 8:50:41 AM CEST Pingfan Liu wrote:
> > Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
> > correct device's shutdown order"). So later we can revert it safely.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > ---
> >  drivers/base/core.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 684b994..db3deb8 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
> >  {
> >       struct device_link *link;
> >
> > -     /*
> > -      * Devices that have not been registered yet will be put to the ends
> > -      * of the lists during the registration, so skip them here.
> > -      */
> > -     if (device_is_registered(dev))
> > -             devices_kset_move_last(dev);
> > -
> >       if (device_pm_initialized(dev))
> >               device_pm_move_last(dev);
>
> You can't do this.
>
> If you do it, that will break power management in some situations.
>
Could you shed light on it? I had a quick browsing of pm code, but it
is a big function, and I got lost in it.
If the above code causes failure, then does it imply that the seq in
devices_kset should be the same as dpm_list? But in device_shutdown(),
it only intersect with pm by
pm_runtime_get_noresume(dev) and pm_runtime_barrier(dev). How do these
function affect the seq in dpm_list? Need your help to see how to
handle this issue.

Thanks and regards,
Pingfan
