Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog125.obsmtp.com ([207.126.144.159]:45383 "EHLO
	eu1sys200aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756074AbaCDD7n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Mar 2014 22:59:43 -0500
Date: Tue, 4 Mar 2014 09:29:17 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCIE: Program pcie device private registers
Message-ID: <20140304035917.GA3032@pratyush-vbox>
References: <CAHH3p5JzL-9T-Hn=fp1S9=URzycpKTy6toaA0AjQfJYt7mQXsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAHH3p5JzL-9T-Hn=fp1S9=URzycpKTy6toaA0AjQfJYt7mQXsA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 05:12:38PM +0800, shiv prakash Agarwal wrote:
>    Hi All,
> 
>     
> 
>    One query:
> 
>     
> 
>    We can program config space registers of a pcie device using setpci but
>    how can we program private registers of a pcie device?

You mean application specific registers?
These registers will not be accessible through any generic user space program.

If you want to access them for debug purposes then you can provide
support in your driver.

Regards
Pratyush
> 
>    Can it be done through PCIE interface or something else?
> 
>     
> 
>    With best,
> 
>    Jay
