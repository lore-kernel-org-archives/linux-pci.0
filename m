Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com ([104.47.41.66]:15328
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756976AbdACA0S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Jan 2017 19:26:18 -0500
Date: Mon, 2 Jan 2017 16:26:07 -0800
From: Satanand Burla <satananda.burla@caviumnetworks.com>
To: Martin Mares <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] pciutils: Add decode for Atomic Ops in lspci
Message-ID: <20170103002607.syhxuum4it6zx2ck@caviumnetworks.com>
References: <1482882756-12151-1-git-send-email-satananda.burla@caviumnetworks.com>
 <mj+md-20161231.152720.17786.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <mj+md-20161231.152720.17786.albireo@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The 12/31/2016 16:28, Martin Mares wrote:
> Hi!
> 
> > This adds support for decoding Atomic ops added in ECN
> > https://pcisig.com/sites/default/files/specification_documents/ECN_Atomic_Ops_080417.pdf
> 
> This is much better, however, it still prints extra spaces sometimes.
> Could you please fix it?
> 
Can you let me know in which situation would extra spaces be printed?
Do you want me to get rid of spaces between the fields ?
The outputs look like this
Root complex:
DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
AtomicOpsCtl: ReqEn- EgressBlck-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-

endpoint with memory bar:
DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
AtomicOpsCtl: ReqEn-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-

upstream/downstream port:
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
AtomicOpsCap: Routing-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
AtomicOpsCtl: EgressBlck-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-

> Also, I woule like to have a test case for the new code -- a configuration
> space dump similar to those in tests/*. Do you have one?
Sure.I can provide this as an updated patch.
> 
> 				Martin

-- 
Regards
Satanand
