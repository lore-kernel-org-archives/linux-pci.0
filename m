Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:52204 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932354AbeCSK3f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 06:29:35 -0400
Date: Mon, 19 Mar 2018 13:29:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Message-ID: <20180319102920.tx6hpjyyqooij5xi@mwanda>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
 <20180319083850.tglknmwwybdhahfl@mwanda>
 <63a95bfd-0199-b935-b8d0-2b73d82e8d46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <63a95bfd-0199-b935-b8d0-2b73d82e8d46@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Smatch tracks information about every function call.  When a function
pointer is called it maybe looks something like this:

     kernel/module.c |   SYSC_delete_module | (struct module)->exit |    INTERNAL |  -1 |  | void(*)()

So then we just have to know what functions are assigned to
module->exit.

I also filter based on the function signature "void(*)()" because
there are a couple places where we cut and pasted so the structs can
have the same name and function pointer name as a member but take
different arguments.

regards,
dan carpenter
