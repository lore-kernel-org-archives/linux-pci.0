Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:46194 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbeBOKc4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Feb 2018 05:32:56 -0500
Date: Thu, 15 Feb 2018 11:32:55 +0100
From: Martin Mares <mj@ucw.cz>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] lspci: Add support of JSON output format
Message-ID: <mj+md-20180215.103138.21596.nikam@ucw.cz>
References: <20180214160741.8958-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180214160741.8958-1-viktor.prutyanov@virtuozzo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> This collection of patches adds support of printing PCI info in JSON format

First of all, I would really like to hear the reasons behind that --
especially why the current machine-readable format is not sufficient.

Generally, adding 1000 lines of code which duplicate a lot of existing
logic should have a strong reason.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
return(ENOTOBACCO); /* Read on an empty pipe */
