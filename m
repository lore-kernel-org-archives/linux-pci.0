Return-Path: <SRS0=uePl=5A=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2C8C5ACBF
	for <linux-pci@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022D2205F4
	for <linux-pci@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239089;
	bh=dQfzPYyCYdN+44zCm9AjIC54G7c/pVQL8vwGNg36xK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iShWBKBHUTxiYizjXPx/Fw9DuK0EybBEulWep5foVDjUVxoTfcYKkKB45nyVmerh2
	 5T4iVWkDS/bJyfnLGl3JCWbPJD4zkTIoaalfsFILT81Oqv8E1BElp89X/8tyobbo91
	 Lb0v3ardqZlv7GeAsVPhtKcNW0YR1OU9pOxSkdYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCOCYO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbgCOCYN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0CDC2073E;
        Sat, 14 Mar 2020 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584184825;
        bh=dQfzPYyCYdN+44zCm9AjIC54G7c/pVQL8vwGNg36xK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztNmQ9imaYg944LP2Tp1jJ8ZgvjqCngYPQRGC11tXYfpCbCRmX3lG6VlrNhesKoiL
         2jq4LXNkX4Yb0W7o68AWIZup5z+o12xuG9ESxbf7yoT1mGRh7uQotFPOSRNMjiMtiy
         zqzD4xyg/t8ifygN/+2fSg+esmPPWYBk9U4Jz0X0=
Date:   Sat, 14 Mar 2020 12:20:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com, rbilovol@cisco.com
Subject: Re: [PATCH v3 1/4] PCI: sysfs: Define device attributes with
 DEVICE_ATTR*
Message-ID: <20200314112022.GA53794@kroah.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-2-skunberg.kelsey@gmail.com>
 <CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 12:51:47PM +0200, Ruslan Bilovol wrote:
> On Thu, Aug 15, 2019 at 7:01 PM Kelsey Skunberg
> <skunberg.kelsey@gmail.com> wrote:
> >
> > Defining device attributes should be done through the helper
> > DEVICE_ATTR_RO(), DEVICE_ATTR_WO(), or similar. Change all instances using
> > __ATTR* to now use its equivalent DEVICE_ATTR*.
> >
> > Example of old:
> >
> > static struct device_attribute dev_name_##_attr=__ATTR_RO(_name);
> >
> > Example of new:
> >
> > static DEVICE_ATTR_RO(_name);
> >
> > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
> >  1 file changed, 27 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 965c72104150..8af7944fdccb 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
> >         }
> >         return count;
> >  }
> > -static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> > -                                                       (S_IWUSR|S_IWGRP),
> > -                                                       NULL, dev_rescan_store);
> > +static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
> >
> >  static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> >                             const char *buf, size_t count)
> > @@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> >                 pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> >         return count;
> >  }
> > -static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
> > -                                                       (S_IWUSR|S_IWGRP),
> > -                                                       NULL, remove_store);
> > +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
> > +                                 remove_store);
> >
> >  static ssize_t dev_bus_rescan_store(struct device *dev,
> >                                     struct device_attribute *attr,
> > @@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
> >         }
> >         return count;
> >  }
> > -static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> > +static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);
> 
> This patch renamed 'rescan' to 'bus_rescan' and broke my userspace application.
> There is also mismatch now between real functionality and documentation
> Documentation/ABI/testing/sysfs-bus-pci which still contains old "rescan"
> descriptions.
> 
> Another patch from this patch series also renamed 'rescan' to 'dev_rescan'
> 
> Here is a comparison between two stable kernels (with and without this
> patch series):
> 
> v5.4
> # find /sys -name '*rescan'
> /sys/devices/pci0000:00/0000:00:01.2/dev_rescan
> /sys/devices/pci0000:00/0000:00:01.0/dev_rescan
> /sys/devices/pci0000:00/0000:00:04.0/dev_rescan
> /sys/devices/pci0000:00/0000:00:00.0/dev_rescan
> /sys/devices/pci0000:00/pci_bus/0000:00/bus_rescan
> /sys/devices/pci0000:00/0000:00:01.3/dev_rescan
> /sys/devices/pci0000:00/0000:00:03.0/dev_rescan
> /sys/devices/pci0000:00/0000:00:01.1/dev_rescan
> /sys/devices/pci0000:00/0000:00:02.0/dev_rescan
> /sys/devices/pci0000:00/0000:00:05.0/dev_rescan
> /sys/bus/pci/rescan
> 
> v4.19
> # find /sys -name '*rescan'
> /sys/devices/pci0000:00/0000:00:01.2/rescan
> /sys/devices/pci0000:00/0000:00:01.0/rescan
> /sys/devices/pci0000:00/0000:00:04.0/rescan
> /sys/devices/pci0000:00/0000:00:00.0/rescan
> /sys/devices/pci0000:00/pci_bus/0000:00/rescan
> /sys/devices/pci0000:00/0000:00:01.3/rescan
> /sys/devices/pci0000:00/0000:00:03.0/rescan
> /sys/devices/pci0000:00/0000:00:01.1/rescan
> /sys/devices/pci0000:00/0000:00:02.0/rescan
> /sys/devices/pci0000:00/0000:00:05.0/rescan
> /sys/bus/pci/rescan
> 
> Do we maintain this kind of API as non-changeable?

Yeah, that's a bug and should be fixed, sorry for missing that on
review.

Kelsey, can you fix this up?

thanks,

greg k-h
