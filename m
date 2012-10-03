Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60882 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab2JCNAP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 09:00:15 -0400
Received: by pbbrr4 with SMTP id rr4so9832020pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 03 Oct 2012 06:00:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <506B575A.4060304@redhat.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
	<CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
	<506B4D4C.3080101@redhat.com>
	<20121002203951.GA28663@kroah.com>
	<506B575A.4060304@redhat.com>
Date: Wed, 3 Oct 2012 09:00:14 -0400
Message-ID: <CACJDEmroM_E3hXR9pc=9+j_gNJs9HZb76=4S5MJGWg2T=FBTWw@mail.gmail.com>
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
From: Konrad Rzeszutek Wilk <konrad@kernel.org>
To: Don Dutile <ddutile@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> Also, you need to do this _before_ the device shows up to userspace,
>> otherwise you have a race that you just lost with udev and the like.
>>
>> thanks,
>>
>> greg k-h
>
>
> So, why is it ok to create the 'reset' file after the device shows up?
> Like reset, SRIOV is optional.  The sysfs files are designed to only
> be used by userspace utils to enable/disable VFs after the system is up.

It should (the attribute) be there when the device is created. Otherwise you end
up with the case when udev could call 'reset' attribute the moment the
SR-IOV device shows up. Or the userspace utility could.

> Or should the design allow a udev rule to be created that if one
> of these new sriov files exists, then perform a set of read-max-vf &
> enable n-vf ops ?

Well, that depends on the ingenuity of the udev rules writers.  But we should
also make sure that the concept is race-free. You don't want the udev
rules to have 'sleep 1' to work-around the kernel code.
