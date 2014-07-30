Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171AbaG3SGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Jul 2014 14:06:10 -0400
Message-ID: <53D93407.8040308@redhat.com>
Date: Wed, 30 Jul 2014 14:05:59 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Edward Cree <ecree@solarflare.com>, linux-pci@vger.kernel.org
Subject: Re: pci_sriov_set_totalvfs again
References: <53D9288B.5030302@solarflare.com>
In-Reply-To: <53D9288B.5030302@solarflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/30/2014 01:16 PM, Edward Cree wrote:
> Calling pci_sriov_set_totalvfs(dev, 0) has no effect, because pci_sriov_get_totalvfs ignores dev->sriov->driver_max_VFs if it's 0, as that is used as the 'not set' value.
> So, three questions:
> a) is this a bug?
> b) if not, should the comment on pci_sriov_set_totalvfs mention that passing numvfs=0 will be interpreted as numvfs=dev->sriov->total_VFs?
> c) is there a better way of indicating "current configuration doesn't support VFs" rather than calling set_totalvfs(0)?
>
> Thanks,
> -Edward
> ||The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.

The file shouldn't exist if the device doesn't provide an SRIOV capability.
If it does, and it's not supported, then add a patch in quirks.c.


