Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4413DC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 22:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EA0214C6
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 22:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20150623.gappssmtp.com header.i=@gigaio-com.20150623.gappssmtp.com header.b="TjRwhtPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfDXWqW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:46:22 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:43367 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfDXWqW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 18:46:22 -0400
Received: by mail-wr1-f50.google.com with SMTP id a12so4088313wrq.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2019 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ONAeUCHUtTO2iI2iwiPGsSk6ylu5x98/gGJgW88xgaQ=;
        b=TjRwhtPlEFyBRudCGm+z8KqAQ5OXFgZZImcdPjWks0ejWtI+S7GJ2aMrrILAgXR7hy
         xZnaIggS/rqv+qatL88xcYKWeTsmcBNyqm6IqPL39TsYPSxOyFB6u5K2cKq0/7uPAYmJ
         aFWbC5QaC4hDXMvGushhkyAkISFoG8S1gqsQBco6CQ+76fozwdGVO9LV7G1/PtE2d5fH
         SS9JtsOcNiUD7GDLJGcaz0axNgX0cDOs/a06wQ7lO7ku+TUL5Ps0UANcmmOuQh3Qv24g
         60KpsS7ldfOpTEppCk1ggXWlDvfFV30OzdNBVbIy53zPNB1JNW8TciYVYhdSrgNSf7A4
         asWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ONAeUCHUtTO2iI2iwiPGsSk6ylu5x98/gGJgW88xgaQ=;
        b=ohsnsndqHaT3QPyz/S/o4V768DvKJDE9HiLE6FNCuACOaWlwct/lGNTgEEahWLbASf
         SNHbGUlDbcSKptvQ4//2bnHHIPtrBssvBQzbDaeCLgVq8bRXt5cJRrBCjInHAFQXVzr4
         6lFYjOjKdfSoKpGE6zIfgoylWhE5a8P/t5Q82/7KY9u6Ojsgr+h2s6VzzsiV9IvdCRlA
         YGejKISDKqvxNd6F7Y+4t9hPZ+MH6rSi1UNOzEBmFPPB0aykZDMaCftMcR1sm57Xr0G5
         1cDZohKX+d+z790+yLacH4BmmerwkpCb3+N8IRIhWI4Nr5ogjrJ7MlWtC2WzzWGOY6Tl
         Vghg==
X-Gm-Message-State: APjAAAXpOdWQ0OKlOetgfvKunDOI3sYmGrkmGYEPgurw9/ell+9A3pDS
        EAmFTAWZDgHd3X173xjaizp6TS32OutdrNzsyZct6Q==
X-Google-Smtp-Source: APXvYqyK+BHFUnjFRWdvJkVzhLTMj0APZoyuxJ8b0vQ09/daCBpzrznnjBj9omAuKmFGwv9HzlgtCZS+QVcqaWLiNlc=
X-Received: by 2002:adf:d081:: with SMTP id y1mr13537398wrh.283.1556145979987;
 Wed, 24 Apr 2019 15:46:19 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Wed, 24 Apr 2019 15:46:09 -0700
Message-ID: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
Subject: NVMe peer2peer TLPs over NTB getting split
To:     linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc:     Armen Baloyan <abaloyan@gigaio.com>, D Meyer <dmeyer@gigaio.com>,
        S Taylor <staylor@gigaio.com>, E Pilmore <epilmore@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Folks,

Does anybody know why a Host Bridge might break up a full-sized (max
payload) TLP into single byte TLPs when those TLPs are traveling from
peer-to-peer?

Some context. This issue involves a NVMe drive writing (DMA)
"directly" to the remote memory in a server across a NTB. The
following diagram is intended to show the layout:

     Host                 Host
   (port 8)             (port 0)
     /  \                 /  \
    /    \               /    \
    |    |               |    |
..+-+--+-+--+..........+-+--+-+--+..
: | NT | US |          | NT | US | :
: +-+--+-+--+          +-+--+-+--+ :
:   |                    |    |    :
:   |                    |    |    :
:   +--------------------+    |    :
:                           +-+--+ :
............................| DS |..
    switch                  +-+--+
                              |
                              |
                              |
                             NVMe
                           (port 32)

Sorry if my ascii art did not translate.  In a nutshell:
- PCIe switch in play here is a Switchtec device.
- 3 ports of PCIe switch configured (ports 0, 8, 32).
- Port 8 configured as NT+USP and connected to a Host and in its own partition.
- Port 0 configured as NT+USP and connected to a Host and in its own partition.
- Port 32 configured as a DSP and in the same partition as the host on
Port 0. Thus the NVMe drive is directly accessible by Port 0 Host and
visible in his PCIe tree.
- IOMMU is enabled on both hosts.

The NVMe drive is instructed to send (DMA Write) some data into
buffers that reside in Port 8 Host. The destination address for this
DMA is a PCI BAR based address for the NT interface that Port 0 Host
is plugged into. Under the covers, the NT interface on Port 0 will
translate incoming addresses into a physical DRAM address in Port 8
Host.

The Switchtec device supports a tool that allows us to capture Ingres
(only) TLPs that are entering the switch. As such, for the data path
NVMe -> Port 8 Host, I can capture the TLPs being sent by the NVMe as
well as the same packets getting redirected into the NT on Port 0
Host.

Now for the mystery! The TLP packet capture shows full size (256 byte)
TLPs coming from the NVMe drive into the switch, as we would expect.
However, the packets captured coming from Port 0 host, which are the
relayed packets based on the destination address, are just ONE byte
TLPs!! Note that these TLPs coming through the NT for Port 0 Host have
a RequesterID of the respective Host Bridge, which is presumably
because the transactions had to travel through the IOMMU.

A sample TLP (header) from originating NVMe (port 32):
"60 00 00 40 92 00 00 ff 00 00 02 f0 fe d8 70 00 "
   - BDF of NVMe drive = 92.00
   - TLP size = 0x40 = 64 words = 256 bytes

Sample TLP (header) captured from Port 0 host NT:
"60 00 00 01 00 00 00 01 00 00 02 f0 fe d9 60 14 "
"60 00 00 01 00 00 01 02 00 00 02 f0 fe d9 60 14 "
"60 00 00 01 00 00 02 04 00 00 02 f0 fe d9 60 14 "
"60 00 00 01 00 00 03 08 00 00 02 f0 fe d9 60 14 "
    - BDF of originator = 00.00 (host bridge)
    - TLP size = 0x01 = 1 word = 4 bytes, however 1st BE only has 1
bit set indicating, just one byte in word is valid.

As you can see, 4 TLPs, each writing one byte (note the 1st BE field
01->02->04->08)

Does anybody know why these TLPs might get split up like this? Is it
an oddity of having to go through the IOMMU?  Maybe something related
to endian swapping? Something related to attempting to go
peer-to-peer? Our switch is configured with a TLP max payload of 256
bytes

Sorry for the long email, but any assistance is greatly appreciated.
Thanks,
Eric

-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom
it is addressed and may contain information that is privileged,
confidential, proprietary, or otherwise exempt from disclosure under
applicable law. If you believe you have received this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
