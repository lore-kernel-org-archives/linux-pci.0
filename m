Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1681AC0044C
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 21:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B376D20820
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 21:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRqSNtF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B376D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeKBGfc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:35:32 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:35216 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeKBGfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Nov 2018 02:35:32 -0400
Received: by mail-it1-f170.google.com with SMTP id p64-v6so584563itp.0;
        Thu, 01 Nov 2018 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMBt92T9TcQD2cCam5fs7bXoQn7SSU4IZU7mi24OtCw=;
        b=bRqSNtF4Qw5Jp/KghBsdF1zt9J+Xb6C3nTLwJ7x5UvdtvA01+3tqa06X9YHHIpJD8m
         HCD8buon9MTSiSL3gTYER9cnO0QQ+AGTRO0VXGT3PxcQhk0MsIRuD8juEWzT+tyFzpn6
         MKDOIp5DmVKBIut2ID00lMqYjsW9QEejDZZW2mCgXL9WI2h5SwPWG2hsQLxnfcjwTta8
         pmmtKBI2CXXenNkJ0KkwZ81OTaQA7S0J2UlTjhgRzO5KIUW35jCtKap4z6RaXerEJqNO
         1+viYxD+36VMQvVI5JF32Vr1hQB2HchSLuVr4NG9YSSPJtOPRM0SndyZe7ZuwmtkH+xZ
         1RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMBt92T9TcQD2cCam5fs7bXoQn7SSU4IZU7mi24OtCw=;
        b=i5G6j2bh42rycQmd4eC4GgVkhYSpmV3/WtTb5HZLWZo3RFAcm/GtNHa/Sq97XHzmvY
         MHovWyxEMn6v7PFMqmFhWJg2vL9bl9jmBVKGnfoMJzUgYz3a+CBru2WIYWyw4uyr6Yhg
         p+LyAPtTuad2zk6br5HdueHCBBtzuOCiHpdgGqPJp4i3SP8mzEDnMIxMuId55CtVvycA
         34nqc0CGaLwrGBlM7N/Vd0fUtEgQ6UtZ4y9bXZ+OI1n/Y5aODSRQOJGeL6H7ZpJlfw8Y
         qjgXK50wDHBO+ao5NBN2OnHv7lXdvbtj9ju/pqxlG1BfLOaiqIkKjMxS1dytZJEU7dsE
         Ukhg==
X-Gm-Message-State: AGRZ1gLPgKbrrrOH4EmqTEV9nVPGWwzAZh7c2E9yQWKk9wEcKTt5NMPu
        JTcLmxCu/7jAbqAyTmCV6JWOeplE
X-Google-Smtp-Source: AJdET5e/zaiV9gOwozc6U7nH8tNu4b96GLSEKzc+ESDoOsuK6OIPU/PiJN0hylDfdVBopK5V9uqHkQ==
X-Received: by 2002:a24:a70e:: with SMTP id a14-v6mr6778626itf.74.1541107849632;
        Thu, 01 Nov 2018 14:30:49 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id z18-v6sm10475334iog.57.2018.11.01.14.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:30:48 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: No interrupt was generated using MSI
Date:   Thu,  1 Nov 2018 17:30:44 -0400
Message-Id: <20181101213044.27844-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I am seeing this in my kernel log:

[   10.235625] tg3 0000:03:00.0 eth20: No interrupt was generated using MSI.
	Switching to INTx mode. Please report this failure to the PCI
	maintainer and include system chipset information

I looked through MAINTAINERS, but I can't find the PCI maintainer.
Can anyone help?

Chipset info: this happens on a Freescale i.MX6Q. Mainline 4.19 kernel.
The devicetree entry for the pcie chipset is here:

arch/arm/boot/dts/imx6qdl.dtsi:

pcie: pcie@1ffc000 {
	compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
	<snip>
};
