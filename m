Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:3349 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751367AbcLHOKE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2016 09:10:04 -0500
Subject: Re: [PATCH] pci-error-recover: doc cleanup
To: Jonathan Corbet <corbet@lwn.net>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161208070539.0f00ce71@lwn.net>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linasvepstas@gmail.com>,
        <bhelgaas@google.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58496AA4.5030602@cn.fujitsu.com>
Date: Thu, 8 Dec 2016 22:13:56 +0800
MIME-Version: 1.0
In-Reply-To: <20161208070539.0f00ce71@lwn.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/08/2016 10:05 PM, Jonathan Corbet wrote:
> On Thu, 8 Dec 2016 16:16:14 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>>  The platform resets the link, and then calls the link_reset() callback
>>  on all affected device drivers.  This is a PCI-Express specific state
>> -and is done whenever a non-fatal error has been detected that can be
>> +and is done whenever a fatal error has been detected that can be
>>  "solved" by resetting the link. This call informs the driver of the
> 
> As far as I can tell, the original text was correct here; why do you
> think this change needs to be made?
> 

See do_recovery() in aer core, reset_link() is called only seeing fatal
error.

-- 
Sincerely,
Cao jin


