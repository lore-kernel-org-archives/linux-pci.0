Return-Path: <SRS0=Xsl3=NA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF6ECDE3D
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 02:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0171E214FA
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 02:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKo5aD7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0171E214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJTLGx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 07:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbeJTLGx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Oct 2018 07:06:53 -0400
Received: from [192.168.0.107] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D825F214C3;
        Sat, 20 Oct 2018 02:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540004283;
        bh=b0rWM88X8TBU1rNUbO55x33gOzkASQbrzSdLZ6LSI6s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PKo5aD7htPS42RCPuyVVr47dFkNi4l4iJ2dgOX3Yunf0t0pJo0x4Lqb6oIDmj3CLO
         N5XRLM00WBCxPQBn5f89CMYkSP/n/HbT6GBuVUDUb5p+TF2iXAv0dv75+XNgCk/yu6
         X7fGU344Joo+MSyJFd71N5UWU+UVgaiNNoi3MGh4=
Subject: Re: [PATCH v6 1/7] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20181019021132.14743-1-okaya@kernel.org>
 <20181020020908.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <8f368f0b-b9b9-54ab-bd46-88635b9a43e5@kernel.org>
Date:   Fri, 19 Oct 2018 22:58:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181020020908.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/19/2018 10:09 PM, Bjorn Helgaas wrote:
> This series (and v5, it looks like) lost the cover letter, which had a
> nice diffstat overview :)

Yeah, I was too lazy. I was rushing to get it out of my laptop before I go
back to my daily work.

> 
> On Fri, Oct 19, 2018 at 02:11:21AM +0000, Sinan Kaya wrote:
>> We need a contract between the reset API users and the PCI core about the
>> types of reset that a user needs vs. what PCI core can do internally.
>> If a platform supports hotplug, we need to do hotplug reset as an example.
> 
> Somewhere this needs a description of a bug that's being fixed or some
> other justification, e.g., code simplification.  The above is a little
> too abstract for me to grasp it.
> 

This series was in response to a request from Alex to have external users
some level of control on what PCI core can do internally.

On the other hand, I have been posting patches to remove direct access from
external users to PCI core internals and hide all reset semantics like
save/restore from the users. I like giving less power to the users :)

>> Expose the reset types to the drivers and try different reset types based
>> on the new reset_type parameter.
>>
>> Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
>> PCI_RESET_LINK parameters.
> 
> There are fewer than a dozen callers of all these functions and the
> complication of these interfaces doesn't seem commensurate with the
> problem.  With six different interfaces and five independent bit
> flags, the possibilities are way more than necessary.
> 

True, I posted an RFC to reduce 5 function reset API flavors to 1 and
rely on the flags.

In the end, there would be two reset APIs only.

> It seems like there are only three main cases (possibly extended by
> locked/unlocked versions):
> 
>    - a generic reset, used by ipc, genwqe, qlcnic, sfc, liquidio,
>      mwifiex, xen
> 
>    - something special for VFIO that is affected by the set of devices
>      owned by the user
> 
>    - a link reset for places like these where a device needs help to
>      train the link correctly:
> 
>        cik_pcie_gen3_enable()       # amdgpu, radeon
>        si_pcie_gen3_enable()        # amdgpu, radeon
>        do_pcie_gen3_transition()    # infiniband/hfi1
> 
> The interface for the generic case should be simple and made to be the
> obvious choice for drivers, i.e., requires only the pci_dev and no
> magic flags.  

Even these generic reset examples are not really generic today. Some of them
call reset from probe path and use the locked reset API 
(pci_reset_function_locked()).

Others call the reset but prefer to not save/restore context.
(__pci_reset_function_locked()). Some drivers even implemented their own
context save/restore code themselves.

There are others that do obtain the lock as well as save/restore context.
(pci_reset_function())

I really don't like having these many reset API flavors and I thought
we could do something about that.

We can also drop the series if we think that current API are good enough
and nuances are well understood.

Alex wanted to have some more control into the reset APIs. Thus, this series
+ the API reduction in RFC from me (again Alex didn't like this much).

> The link reset case is different enough that it might
> deserve its own special interface.
> 
>> Link: https://www.spinics.net/lists/linux-pci/msg75828.html
> 
> Can you switch to using https://lore.kernel.org/linux-pci/<Message-ID>
> URLs so we don't depend on 3rd-party archives like spinics?  See
> https://www.kernel.org/lore.html .  I usually silently convert to the
> lore URLs, but I guess doing it silently only makes more work for
> myself.
> 
> Bjorn
> 

