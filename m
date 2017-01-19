Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752322AbdASNA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2017 08:00:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0JCnwRg030628
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2017 07:59:26 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 282b5jtpcb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2017 07:59:26 -0500
Received: from localhost
        by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Thu, 19 Jan 2017 10:59:24 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
        by d24dlp01.br.ibm.com (Postfix) with ESMTP id DF50D352006E
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2017 07:58:49 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
        by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v0JCxLUp31457282
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2017 10:59:21 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
        by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v0JCxLB5011927
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2017 10:59:21 -0200
Subject: Re: PCIe card supporting multiple MSI vectors
To: Stefan Roese <stefan.roese@mailbox.org>
References: <a6eb25e3-effc-39a4-88c1-8309d601d7b9@mailbox.org>
Cc: linux-pci@vger.kernel.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 19 Jan 2017 10:59:20 -0200
MIME-Version: 1.0
In-Reply-To: <a6eb25e3-effc-39a4-88c1-8309d601d7b9@mailbox.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <5880B828.3000302@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/18/2017 08:43 AM, Stefan Roese wrote:
> Hi,
> 
> for some test with MSI related tests I would like to test
> with a desktop PCIe card that supports multiple MSI vectors.
> Could somebody please make a suggestion for such a card
> (not too expansive if possible) with a Linux driver that
> also support multiple MSI vectors?

I'd suggest NVMe PCI card. Some of them support up to 128 MSI-X
interrupts at same time.

The problem is in "not too expansive if possible" heheh
Those cards could be a little bit expensive currently...but worth to
take a look, maybe works for you. Also, nvme driver is pretty good.

Cheers,


Guilherme

> 
> Thanks,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

