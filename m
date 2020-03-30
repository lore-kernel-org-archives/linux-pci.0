Return-Path: <SRS0=Lghl=5P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDECC2D0EE
	for <linux-pci@archiver.kernel.org>; Mon, 30 Mar 2020 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48F420776
	for <linux-pci@archiver.kernel.org>; Mon, 30 Mar 2020 13:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyrPywC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgC3NJm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:09:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57684 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729900AbgC3NJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 09:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585573781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahq/o5I/YbrAOVCAI5uwMxuNLuPNHglciTc/hlUXnN0=;
        b=AyrPywC5VnuAhkoaJZPb6MxYXnPTt2r37mwef772E71Aia+B+1AGQEaYieQyWik1nDJCr7
        yv00zqXga4VbDnVMzohzH4QIhAD9Vbat8LnmsGPzY7WvS/GCKrsdavbobmBBOQCbOtasw6
        /Xp5+HKYixxQr29kjIKp9GWiZY+5Jtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-3INrmXdwM_ykDgQiXmvsRQ-1; Mon, 30 Mar 2020 09:09:36 -0400
X-MC-Unique: 3INrmXdwM_ykDgQiXmvsRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F96F107ACC4;
        Mon, 30 Mar 2020 13:09:34 +0000 (UTC)
Received: from [10.3.114.78] (ovpn-114-78.phx2.redhat.com [10.3.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE1A460C63;
        Mon, 30 Mar 2020 13:09:32 +0000 (UTC)
Subject: Re: [Linux-kernel-mentees] [PATCH v2] PCI: sysfs: Change bus_rescan
 and dev_rescan to rescan
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kelsey <skunberg.kelsey@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Kelsey Skunberg <kelsey.skunberg@gmail.com>,
        rbilovol@cisco.com, stable <stable@vger.kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>
References: <20200328195932.GA96482@google.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <4ab3854e-e7ca-5a3f-dca9-bd855d47e95b@redhat.com>
Date:   Mon, 30 Mar 2020 09:09:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200328195932.GA96482@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/28/20 3:59 PM, Bjorn Helgaas wrote:
> On Thu, Mar 26, 2020 at 12:29:11AM -0600, Kelsey wrote:
>> On Wed, Mar 25, 2020 at 4:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>>> Thanks for taking care of this!  Two questions:
>>>
>>> 1) You supplied permissions of 0220, but DEVICE_ATTR_WO()
>>> uses__ATTR_WO(), which uses 0200.  Shouldn't we keep 0200?
>>>
>>
>> Good catch. Before changing to DEVICE_ATTR_WO(), the permissions used
>> was (S_IWUSR | S_IWGRP), which would be 0220. This means the
>> permissions were mistakenly changed from 0220 to 0200 in the same
>> patch:
>>
>> commit 4e2b79436e4f ("PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()")
>>
>> To verify DEVICE_ATTR_WO() is using __ATTR_WO() can be seen in
>> /include/linux/device.h
>> To verify permissions for __ATTR_WO() is 0200 can be seen in
>> /inlcude/linux/sysfs.h
>>
>> These attributes had permissions 0220 when first being introduced and
>> before the above mentioned patch, so I'm on the side to believe that
>> 0220 should be used.
> 
> I'm not sure it was a mistake that 4e2b79436e4f changed from 0220 to
> 200 or not.  I'd say __ATTR_WO (0200) is the "standard" one, and we
> should have a special reason to use 0220.
> 
Bjorn,
Thanks for verifying the 0200 vs 0220 permissions.
I had recalled that discussion thread on the permissions when the original ATTR patch was proposed, but hadn't had time to dig it up.
Apologies for the delay, thanks for the (final?) cleanup.
- Don

