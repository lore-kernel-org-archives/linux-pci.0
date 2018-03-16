Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:42496 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753536AbeCPQ5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2018 12:57:48 -0400
Date: Fri, 16 Mar 2018 17:57:46 +0100
From: Martin Mares <mj@ucw.cz>
To: "viktor.prutyanov" <viktor.prutyanov@virtuozzo.com>
Cc: linux-pci@vger.kernel.org, dmonakhov@openvz.org
Subject: Re: [PATCH v2 0/2] lspci: Add support of JSON output format
Message-ID: <mj+md-20180316.165540.80555.nikam@ucw.cz>
References: <20180214160741.8958-1-viktor.prutyanov@virtuozzo.com>
 <mj+md-20180215.103138.21596.nikam@ucw.cz>
 <20180219004540.47d0fa1f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180219004540.47d0fa1f@virtuozzo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> Because current machine-readable format is very limited and it is
> difficult to extend it to support verbosity options.
> 
> JSON is defacto standard structured format. The key JSON's advantage is
> good portability and extensibility and rich toolchain support. Almost
> every modern utility has JSON format support for output, for example
> lsblk and lscpu.

I agree that a structured output format can be useful at times,
but I do not think that it is so useful that it justifies duplicating
almost the whole source code of lspci. Essentially, you adding a second
copy of all parsing logic with a different output format.

If you find a way how to reduce the code overlap, I could be willing
to accept the change.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Yes, XSLT is Turing-complete. But so is Intercal.
