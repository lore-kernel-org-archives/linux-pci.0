Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E8C433F5
	for <linux-pci@archiver.kernel.org>; Tue, 22 Feb 2022 14:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiBVOc5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiBVOcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 09:32:50 -0500
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF113137C
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 06:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1645540342; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BLm3yInE1y5M0U/TJY2BnCiimHyVRnxGwxvuXOWrgl9xWB1D/oGLtLDpKJGHvsupq9YdP3sIyTZwcRFtMbCh/RVrIjrIIwQ8fFCGhhUeLOUY2v3pNTdCnuc7Oj1pC8FM7G5tY6TcnHSvc36CAFJtD6c9Cmtun+ErjhbZ3RRhrgc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1645540342; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ABkFEBRknb9drynz/RcwNd5PxuPJK1rXG3lXoRukQXU=; 
        b=QFjZyXebR6GYnR7qwwIC35Y4Sajzq+ElhMZ5VDiK+HWb2alxSas3962o+Q9ECO6pQisXp8cXrvrxH3BfPTfrbxDRIz1QreeEsa7pgOIg+1SfA91a6q5h25x4qrhJwKy24e1b9qrPlPtfQLGGyY6rGsMvRkAXXh2R9VSva79oXLA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1645540342;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=ABkFEBRknb9drynz/RcwNd5PxuPJK1rXG3lXoRukQXU=;
        b=WMBPSPipYoOPVjboettjOLa2JU3LxVRtD4Djwq+O+MUZnH6c+Qv02Pyjluf1ytxH
        vpeMU0035decTvAZ652gHCtE7FV/cnNuJglf47cPzkv8eNBmhhAUvIAdGrmekUBxkKB
        1gFPRghCNmUJdNUAHLQZ5iPmkPHNtXJItXzp6YS0=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1645540341619550.978575665768; Tue, 22 Feb 2022 06:32:21 -0800 (PST)
Received: from  [20.89.50.132] by mail.zoho.com
        with HTTP;Tue, 22 Feb 2022 06:32:21 -0800 (PST)
Date:   Tue, 22 Feb 2022 22:32:21 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "linux-pci" <linux-pci@vger.kernel.org>
Message-ID: <17f21d8f75b.cd205cfe182723.8713720915614530205@zohomail.com>
In-Reply-To: 
Subject: [Question] Is it safe to use ioremap_cache for EPF' BAR mem?
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Say that I have one controller run under EP-mode and its bar 2 is mapped into a large DRAM area actually.  pci_ioremap and its friends just use ioremap internally and are non-cachable by default, so the speed is really slow(in my case write 28m/s and read 3m/d). I wonder is it safe to use ioremap_cache for this bar?


Regards,
Li
