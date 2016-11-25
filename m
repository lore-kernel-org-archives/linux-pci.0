Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dehamd003.servertools24.de ([31.47.254.18]:53699 "EHLO
        dehamd003.servertools24.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932214AbcKYQPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 11:15:44 -0500
Subject: Re: Multiple problems with the Linux kernel on an AMD desktop
To: =?UTF-8?Q?Rog=c3=a9rio_Brito?= <rbrito@ime.usp.br>
References: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
        <20161125070159.ner7xvizvo2upb6h@pd.tnic>
        <20161125160548.b4wxokxffhk5zt6r@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <80eb4533-2233-6b75-eae9-99f6decebd88@ladisch.de>
Date: Fri, 25 Nov 2016 17:15:40 +0100
MIME-Version: 1.0
In-Reply-To: <20161125160548.b4wxokxffhk5zt6r@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rogério Brito wrote:
>     [  130.007219] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0

The evbug module is intended for debugging; it dumps all input events
into syslog.  If you do not want these messages, do not load this module.
(If it is loaded automatically, you have an actual bug.)


Regards,
Clemens
