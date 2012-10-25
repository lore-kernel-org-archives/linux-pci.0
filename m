Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18280 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759022Ab2JYNTq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 09:19:46 -0400
Message-ID: <50893C5F.7000308@redhat.com>
Date: Thu, 25 Oct 2012 09:19:27 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Yuval Mintz <yuvalmin@broadcom.com>
CC: "Rose, Gregory V" <gregory.v.rose@intel.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [RFC v2] PCI: sysfs per device SRIOV control and status
References: <1349388885-43938-1-git-send-email-ddutile@redhat.com> <5070768C.4030905@gmail.com> <20121008084439.00006e56@unknown> <50746F77.60201@redhat.com> <C5551D9AAB213A418B7FD5E4A6F30A071533B57E@ORSMSX106.amr.corp.intel.com> <5074A9DD.3000800@redhat.com> <50878105.8000503@broadcom.com>
In-Reply-To: <50878105.8000503@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/24/2012 01:47 AM, Yuval Mintz wrote:
>>> I've finished some patches for the ixgbe driver and they are under internal review.  Testing turned out pretty well.  Hopefully they'll be ready for posting tomorrow afternoon since I'm gone Thursday and Friday.  They'll be based on your RFC v2 patch.  I don't expect many changes will be required for the next version of your patch.
>>>
>>> - Greg
>>>
>> Great!
>> I'll work on re-doing the patch set to have just the two sysfs files
>> as discussed above.
>> We can make an incremental change to move the sriov_enable/disable since
>> your patch has it ready to do just that.
>
> Hi,
>
> I've failed to find [RFC v3]; Will such a series be sent in the imminent future?
>
> Thanks,
> Yuval
>
>
Sorry for delay... (many) customers getting in the way again! ;-)
I'll be posting a V3 set shortly.
Testing w/patches Greg Rose gave me for ixgbe to fully exercise the
good & failure paths, so the V3 set should be in good functional
shape; just finished the testing late last night.


