Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD948C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605972082F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RTcmFmkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605972082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeLJVtd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:49:33 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39368 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVtd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 16:49:33 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BF00324E0BA3;
        Mon, 10 Dec 2018 13:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544478572; bh=4rCpu/J6BE82PO0Ojvfqeaqbxiy98hc74Sq0nPrgEqI=;
        h=From:To:CC:Subject:Date:References:From;
        b=RTcmFmkRperErOmvVB422aHbBE91bN+xR7p1yCeGXudAkLAfNoV7FVcGmTWcEgxP3
         rWY0NtWM+42pbXZprolHLKT8D6V0tKMmnX35cx4tZQTCx7QyvbIyFIhQ+RclzX2XOv
         85kT96zsFIxgzJMzjiezFjqK5VOYeOgtZnjtiDTufQ5lAyLy0WpFqhLTX43VgysRnh
         zvCWtgxstrXtbZAR+NdJ9MNyVHYOGn+OCz2lPp9iGIq3GZy7u1igex/QN/YG/v9lxp
         3DndSYcqSinaFUayPRe0SQazKU3eEJRZJKSLYS6Z7g9X6R7qXgMZOJ9pXaAx8hN/l/
         30o+VQ4HrVRBw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id A47B35BA9;
        Mon, 10 Dec 2018 13:49:32 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 10 Dec 2018 13:49:32 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        John Youn <john.youn@synopsys.com>
Subject: Re: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs
Thread-Topic: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device
 IDs
Thread-Index: AQHUcxc2npgO4DNYfE616LUlhA3Gjw==
Date:   Mon, 10 Dec 2018 21:49:31 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639A8E68@us01wembx1.internal.synopsys.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
 <20181210184954.GA47246@google.com>
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

Hi Bjorn,=0A=
=0A=
On 12/10/2018 10:49 AM, Bjorn Helgaas wrote:=0A=
> On Fri, Nov 02, 2018 at 06:47:38PM -0700, Thinh Nguyen wrote:=0A=
>> Move Synopsys HAPS platform device IDs to pci_ids.h.=0A=
>>=0A=
>> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
> 1) Run "git log --oneline include/linux/pci_ids.h" and follow the=0A=
> style convention for patch subject.=0A=
>=0A=
> 2) Explain in the changelog why we're moving this to pci_ids.h.  Note=0A=
> the comment at the top of pci_ids.h.  I think the move is fine because=0A=
> you're using the definition in two places, so just mention that in the=0A=
> changelog.=0A=
>=0A=
> Thanks!=0A=
=0A=
Thanks for the review! I'll fix it.=0A=
=0A=
Thinh =0A=
=0A=
