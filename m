Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932726AbcLIGu0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2016 01:50:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uB96mlVZ010110
        for <linux-pci@vger.kernel.org>; Fri, 9 Dec 2016 01:50:25 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0b-001b2d01.pphosted.com with ESMTP id 277gu7h7h8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 09 Dec 2016 01:50:24 -0500
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Fri, 9 Dec 2016 16:50:22 +1000
Subject: Re: [PATCH] pci-error-recover: doc cleanup
To: linasvepstas@gmail.com, Cao jin <caoj.fnst@cn.fujitsu.com>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161208070539.0f00ce71@lwn.net> <58496AA4.5030602@cn.fujitsu.com>
 <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 9 Dec 2016 17:50:17 +1100
MIME-Version: 1.0
In-Reply-To: <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3ed3151c-eeef-940c-8a9c-49cf53a51d49@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/12/16 17:24, Linas Vepstas wrote:
> I suppose I'm confused, but I recall that link resets are non-fatal.
> Fatal errors typically require that the the pci adapter be completely
> reset, any adapter firmware to be reloaded from scratch, the device
> driver has to kill all device state and start from scratch. Its huge.

Is there a difference in terminology between an AER fatal error and what 
EEH/IBM people think of as a fatal error?

> If the fatal error is on pci device that is under a block device
> holding a file system, then (usually) there is no way to recover,
> because the block layer (and file system) cannot deal with a block
> device that disappeared and then reappeared some few seconds later.
> (maybe some future zfs or lvm or btrfs might be able to deal with
> this, but not today)

Is this still true? I'm not at all familiar with the block device side 
of it, but the cxlflash driver has reasonably full EEH support, 
including surviving a full PHB fence and complete reset.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

