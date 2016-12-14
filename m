Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55335 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754620AbcLNCkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2016 21:40:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBE2eBXs022328
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2016 21:40:16 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27ap8j125j-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2016 21:40:15 -0500
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 14 Dec 2016 12:39:55 +1000
Date: Wed, 14 Dec 2016 13:39:50 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linasvepstas@gmail.com, Cao jin <caoj.fnst@cn.fujitsu.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci-error-recover: doc cleanup
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161208070539.0f00ce71@lwn.net>
 <58496AA4.5030602@cn.fujitsu.com>
 <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com>
 <3ed3151c-eeef-940c-8a9c-49cf53a51d49@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ed3151c-eeef-940c-8a9c-49cf53a51d49@au1.ibm.com>
Message-Id: <20161214023949.GA9896@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 09, 2016 at 05:50:17PM +1100, Andrew Donnellan wrote:
>On 09/12/16 17:24, Linas Vepstas wrote:
>>I suppose I'm confused, but I recall that link resets are non-fatal.
>>Fatal errors typically require that the the pci adapter be completely
>>reset, any adapter firmware to be reloaded from scratch, the device
>>driver has to kill all device state and start from scratch. Its huge.
>
>Is there a difference in terminology between an AER fatal error and what
>EEH/IBM people think of as a fatal error?
>

They are different things. AER fatal error can lead to frozen PE error,
not fenced PHB error basing on the configuration on PHB.

>>If the fatal error is on pci device that is under a block device
>>holding a file system, then (usually) there is no way to recover,
>>because the block layer (and file system) cannot deal with a block
>>device that disappeared and then reappeared some few seconds later.
>>(maybe some future zfs or lvm or btrfs might be able to deal with
>>this, but not today)
>
>Is this still true? I'm not at all familiar with the block device side of it,
>but the cxlflash driver has reasonably full EEH support, including surviving
>a full PHB fence and complete reset.
>

It's still true, especially when the recovery is going to affect the
rootfs. On completion of error recovery, the driver (if necessary)
and filesystem needs to be reloaded which depends on script or daemon
and they are unavailable in this scenario.

Thanks,
Gavin

