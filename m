Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29282C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F8B20819
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aMVLJkL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F8B20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeKFEH1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:07:27 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:46304 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFEH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 23:07:26 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BBD8624E0810;
        Mon,  5 Nov 2018 10:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541443587; bh=Zl6thV4dRwMM2gbmLYeOO14pidJScTfMKBc/QA3OFPY=;
        h=From:To:CC:Subject:Date:References:From;
        b=aMVLJkL+h7zwr0qy2fDaGRM5yBFexEvHsnqVargqRFecbLzSmNO2ZaPRb4Ab4Qqbg
         X9a7RSyx8ngkGrYCpDXLtCWVdMHIuJp7AiUiXvIiLZLp3LgooVxaZkFB1uc4Wqv7a7
         4SXjIHY7UV6WUcRqbGnEhrgXTODmdN6Z/q+ZwH3h41p4kwf827FMPbBsixI1yUtlA/
         E2uQ05fipxHjinY289K6fMhBoHs4/tFuNX9ZkFXDsYbil1HT3udmQv/t/qjQiPKOL6
         eJL7XMdYnFl1cDEQmYPxHmx7nPRxlkCiYTaye9CoBhJ666tInQoE+67foF+SSm6tZR
         hq6d1aKcJRcyg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7E39A5449;
        Mon,  5 Nov 2018 10:46:27 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 5 Nov 2018 10:46:27 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Youn <john.youn@synopsys.com>
Subject: Re: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs
Thread-Topic: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device
 IDs
Thread-Index: AQHUcxc2npgO4DNYfE616LUlhA3Gjw==
Date:   Mon, 5 Nov 2018 18:46:26 +0000
Message-ID: <30102591E157244384E984126FC3CB4F6399E2F1@us01wembx1.internal.synopsys.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
 <20181103062554.GA32644@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,=0A=
=0A=
On 11/2/2018 11:26 PM, Greg KH wrote:=0A=
> On Fri, Nov 02, 2018 at 06:47:38PM -0700, Thinh Nguyen wrote:=0A=
>> Move Synopsys HAPS platform device IDs to pci_ids.h.=0A=
> Why?  pci_ids.h, at the top of the file, says to not add new entries to=
=0A=
> the file.=0A=
=0A=
Yes, I notice. However, I want to reference these IDs in=0A=
/drivers/pci/quirks.c. It's related to this patch subject "[PATCH 2/2]=0A=
pci: quirks: Override Synopsys USB 3.x HAPS device driver".=0A=
I will CC that patch to linux-usb mailing list also. Please let me know=0A=
if this is ok. Otherwise, any suggestion?=0A=
=0A=
Thanks,=0A=
Thinh=0A=
