Return-Path: <SRS0=Pe2C=XZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49DC32793
	for <linux-pci@archiver.kernel.org>; Mon, 30 Sep 2019 02:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA162086A
	for <linux-pci@archiver.kernel.org>; Mon, 30 Sep 2019 02:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asNdDYu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfI3CJD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 29 Sep 2019 22:09:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41625 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3CJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2019 22:09:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so4665710pfh.8
        for <linux-pci@vger.kernel.org>; Sun, 29 Sep 2019 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUoklqhdz+06Es4zydiqQcrTeUMxMd/mLUALLm71lfY=;
        b=asNdDYu0omLbaxUEQaI81/0xPdH6rv7dCsYzRxa5Ypn+z7n3HhcsnxqqXJ71hDmPR1
         xztElkuHfkuxIOzFh4a/AtJMWn0dSigtHeS+y8qFyQJ3xbXcoTcNrmBfswV57qKm3Y9b
         wmDJkLvYRLZFJserkfEBtvuHEXaJI/ZyH3rXOPELswCKLz1SQkGjFIxkwVP/td7Y3ZeG
         w6EKaJf+bvfYdxVTs/4LA5wX7dFZMiTtcFmHE0V5Xf+E0jrHF8YRRbr6PQbZ8J/hFoeY
         ufdJ1zLjDRx/vAZVkRtfVofyB326sUtc17XXJZBsnm2lMjZuVPyhroXEU+iAqpy4bMKV
         wW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUoklqhdz+06Es4zydiqQcrTeUMxMd/mLUALLm71lfY=;
        b=DTO/257lahAUo9mCEVZK9yn26F2mr+TaWyg+N4oUYgppCsH73w+j6ycaEEG1/thQtE
         PzFI42f0Y0lfk7eRtPYexEC/Jp0Mzj0R7+fEoFWX5mVGAKXyubPU/OrXYMaLSR4JB9W9
         vFGxlu4rlPaCYdJhbnVrC62RlS5b/Wmvkb6C0JfqDvkwIpJw+1KWGGjAsxTzD1eyWLSo
         3T18NtgCraxNlXybY0SLVolIaFWc7R8fUlKJl609BrsAVpRcUk9fFKb1z4GqoIXr08YE
         nky69G+UlaQ1GzXSkARAXAnL+odoQJqtVON2cJ1nRNACe72n0Lu/ko6ZJYYlSRMdqerh
         MMSg==
X-Gm-Message-State: APjAAAXxiTm3qNivQULHyQCoqwxUnfhxRXqh9q5123i5V8MvxPBiiwxF
        TzxJaIfQa2gGLtZiZNO0IDJhlRKA
X-Google-Smtp-Source: APXvYqyK6ilpREDn7g+CUxhDDvcld71JHVsbWRjGK9GVV2y8MzPM3ByZJAbP+y91ViNrEB1ey2l3mg==
X-Received: by 2002:a62:7912:: with SMTP id u18mr18249781pfc.242.1569809342296;
        Sun, 29 Sep 2019 19:09:02 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id x72sm11450733pfc.89.2019.09.29.19.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 19:09:01 -0700 (PDT)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     aik@ozlabs.ru, shawn@anastas.io, linux-pci@vger.kernel.org
Subject: IOMMU group creation for pseries hotplug, and powernv VFs
Date:   Mon, 30 Sep 2019 12:08:45 +1000
Message-Id: <20190930020848.25767-1-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A couple of extra patches on top of Shawn's existing re-ordering patch.
This seems to fix the problem Alexey noted with Shawn's change causing
VFs to lose their IOMMU group. I've tried pretty hard to make this a
minimal fix it's still a bit large.

If mpe is happy to take this as a fix for 5.4 then I'll leave it,
otherwise we might want to look at different approaches.


