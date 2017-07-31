Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbdGaPqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2017 11:46:40 -0400
Date: Mon, 31 Jul 2017 08:46:36 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Sandeep Singh <ssingh1@amd.com>
Cc: Sandeep Singh <Sandeep.Singh@amd.com>, mathias.nyman@intel.com,
        bhelgaas@google.com, dheitmueller@kernellabs.com,
        stern@rowland.harvard.edu, samuel.thibault@ens-lyon.org,
        lukas@oxygene.sk, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH] usb: xhci: Add quirk for Certain failing HP keyboard on
 reset after resume
Message-ID: <20170731154636.GA27596@kroah.com>
References: <1501144509-19357-1-git-send-email-Sandeep.Singh@amd.com>
 <20170730141159.GA21849@kroah.com>
 <060e5b58-07ff-4e2c-9739-d75c3c40c085@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <060e5b58-07ff-4e2c-9739-d75c3c40c085@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top


On Mon, Jul 31, 2017 at 12:10:08PM +0530, Sandeep Singh wrote:
> Hi Greg,
> 
> Thanks for review. Apart from pci_ids.h, I see only 3 options, add this id as macro in pci_quirks.c
> or pci_quirks.h or just hardcode it.
> 
> please suggest what will good option as per your view.

As you only use it in one place, why not just hardcode it there?

thanks,

greg k-h
