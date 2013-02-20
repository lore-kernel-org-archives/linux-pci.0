Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:64923 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966Ab3BTSM3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2013 13:12:29 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so3002886pbc.40
        for <linux-pci@vger.kernel.org>; Wed, 20 Feb 2013 10:12:29 -0800 (PST)
Date: Wed, 20 Feb 2013 06:18:46 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Pramod KS <prsudhee@outlook.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux reserved MSI - how many?
Message-ID: <20130220141846.GB5705@kroah.com>
References: <COL002-W3294F1D83AA5EB392D867DD4F50@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <COL002-W3294F1D83AA5EB392D867DD4F50@phx.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 19, 2013 at 09:07:09AM +0000, Pramod KS wrote:
> I'm tasked to find out number of MSI that kinux kernel reserve for itself.

What do you mean by "reserve for itself"?  And why do you need this
number, what will you do with it?

> I'm not sure where to find the exact numbers.

Have you run in MSI mode and looked?

greg k-h
