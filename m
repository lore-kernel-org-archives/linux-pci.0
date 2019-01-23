Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7807C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 20:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750F121855
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JheKH191"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfAWU61 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:58:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38029 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfAWU60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 15:58:26 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so1217233itc.3;
        Wed, 23 Jan 2019 12:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jcxjcznNr8fhQvN19CGJU9LPx+0Wt0K4AysbeWt2Ozs=;
        b=JheKH191WsIPhGrlq/Y9XVfjY1pS2g6NHv7m/espboZ0DyH9/tThIgjdoaJBNh3UY5
         TQ6mFlnjj7MhIkfonQDva103raH9/WJFJIT0oZ0EBWYSGIvKm8vKvp9uYCdD738jMMHV
         kI51Ou8TOzEoCVSdDD2fMxoqKOInI3Sp+1CMH3HbAkJadUE7qsDEETGVYExZuGAaLnBF
         GZ/iA79CGmqUR42qAtYTeecDCoIg03blaDIiVhJprj77LDxH9zvcgsUKfwsyPVlI8dR2
         lnC9D849jUTP/bIq4a36hzr/pdaGHj4+5tyCpH9RribAZvFbx/JrQiYMY0RWONycym3k
         Tq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jcxjcznNr8fhQvN19CGJU9LPx+0Wt0K4AysbeWt2Ozs=;
        b=XCzT3bsCSx1SAZp78kQ6irxtDhbUIvdy7mE4EqhehyAK+buSA/B2kFbf0W/Tv6S44f
         A6bNR1U3uthyxMUWB9O0NwGzt1LWavH1jptzSTALIzlYFcE7ibfmZy53274U/0HWrXfu
         V24Fjo5sUPiIIb2kYYRzLoe5kEAmAZIKPXsbPaRThqO3JyzziXo1NthCEtptwRhsCn1q
         Hq2bsmIF+zvmjPGk5NvZhOB8uq7e/M2V1szAgL/lHUdR0OswdVak7KbMbZ6IwyHl3gqP
         kVmqCwmZVocgCHuk+SySB+jTMMvTAeYba9aXFvZO3d4OiYVskbGAjCYjofnK3qiccbG3
         Zhbw==
X-Gm-Message-State: AJcUukdAGsruu0vy+vgMQUqF3Lcz+on9j92pLdXB94pEypSOqtZBTRgC
        0TevWMVg0v6DReSjKxImvsy0D/I1HdM=
X-Google-Smtp-Source: ALg8bN6JG/AOsX26NZTsjhqNK30UqzszBc5GYvWhKLr9RiNhMNRM2Qh9DdxrCyxjroQjc2phhN2icw==
X-Received: by 2002:a24:2914:: with SMTP id p20mr2684191itp.38.1548277106128;
        Wed, 23 Jan 2019 12:58:26 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id z133sm9445150itb.36.2019.01.23.12.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 12:58:25 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:58:23 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH 0/2] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset and
 cpumask_to_vpset()
Message-ID: <cover.1548232616.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset removes a duplicate definition of VP set (hv_vp_set) and uses
the common definition (hv_vpset) that is used in other places. It also
removes the duplicate implementation of cpumask_to_vpset() and uses the
shared implementation. Finally, it exports hv_max_vp_index, which is
required by cpumask_to_vpset().

Maya Nakamura (2):
  PCI: hv: Replace hv_vp_set with hv_vpset
  PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()

 arch/x86/hyperv/hv_init.c           |  1 +
 drivers/pci/controller/pci-hyperv.c | 60 ++++++++++++++---------------
 2 files changed, 29 insertions(+), 32 deletions(-)

-- 
2.17.1

