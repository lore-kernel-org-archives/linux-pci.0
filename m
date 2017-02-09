Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:48804 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdBIK5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2017 05:57:12 -0500
Date: Thu, 9 Feb 2017 11:39:07 +0100
From: Martin Mares <mj@ucw.cz>
To: Satanand Burla <satananda.burla@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pciutils: Add decode for Atomic Ops in lspci
Message-ID: <mj+md-20170209.103756.31077.nikam@ucw.cz>
References: <1482882756-12151-1-git-send-email-satananda.burla@caviumnetworks.com>
 <mj+md-20161231.152720.17786.albireo@ucw.cz>
 <20170103002607.syhxuum4it6zx2ck@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170103002607.syhxuum4it6zx2ck@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> Can you let me know in which situation would extra spaces be printed?

Sorry, I misread the patch. It is correct.

So the only thing which remains to be done is a test case.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"A semicolon. Another line ends in the dance of camel." -- Kabir Ahuja
