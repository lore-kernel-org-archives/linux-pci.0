Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27994 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756380AbcLSPzB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Dec 2016 10:55:01 -0500
Subject: Re: [PATCH] infiniband/hfil: drop pci_link_reset()
To: Cao jin <caoj.fnst@cn.fujitsu.com>, linux-rdma@vger.kernel.org
References: <1482129996-19255-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <1482129996-19255-2-git-send-email-caoj.fnst@cn.fujitsu.com>
Cc: dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-pci@vger.kernel.org
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <e6f22b2d-faf7-390a-ca4d-564c6d0841b8@intel.com>
Date: Mon, 19 Dec 2016 10:54:59 -0500
MIME-Version: 1.0
In-Reply-To: <1482129996-19255-2-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/19/2016 01:46 AM, Cao jin wrote:
> In AER recovery, pci_error_handlers.link_reset() is never called,
> drop it now.
>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Is this part of a larger patch series? If the function is never called 
it should be removed from struct pci_error_handlers should it not? Then 
in the same series be removed from all the drivers.

Probably should check with the folks on linux-pci about this though.

-Denny

