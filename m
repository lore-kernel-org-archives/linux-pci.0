Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:57962 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCTUeF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2018 16:34:05 -0400
Date: Tue, 20 Mar 2018 21:34:03 +0100
From: Martin Mares <mj@ucw.cz>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: linux-pci@vger.kernel.org, dmonakhov@openvz.org
Subject: Re: [PATCH v1] lspci: fix printing DeviceName
Message-ID: <mj+md-20180320.203357.93255.nikam@ucw.cz>
References: <1521573634-5635-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521573634-5635-1-git-send-email-viktor.prutyanov@virtuozzo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> In commit ef6c9ec3a45992d9e7ef4716d444252baf2013e1 pci_fill_info() calls were moved
> and the label field is filled after its output.
> Before this patch lspci never prints 'DeviceName'.

Thanks, applied.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
God is real, unless declared integer.
