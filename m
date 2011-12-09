Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44012 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1LIMpa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2011 07:45:30 -0500
Date: Fri, 9 Dec 2011 12:45:25 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Anand Kanaginhal <anand_dk@hotmail.com>
Cc: bhelgaas@google.com, greg@kroah.com,
	Linux PCI mailing <linux-pci@vger.kernel.org>,
	linux kernel mailing <linux-kernel@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>
Subject: Re: PCIe Hotplugging not working
Message-ID: <20111209124524.GA3488@srcf.ucam.org>
References: <BAY163-W52E309F419E3588206D889FBB30@phx.gbl>
 <BAY163-W47DD39095DA3EB108AA3F2FBB30@phx.gbl>
 <20111130154022.GA1411@srcf.ucam.org>
 <BAY163-W80F10350D24162EFC3699FBB00@phx.gbl>
 <20111130182423.GA4831@srcf.ucam.org>
 <CAErSpo5SvHSJrdkWituFq11hMt=jbiobnxHeddN9Xf4DmK640g@mail.gmail.com>
 <BAY163-W600D6D6A04D4BAE8278907FBB90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY163-W600D6D6A04D4BAE8278907FBB90@phx.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Do you have anything in /sys/class/pci/slots ? Does your card show up in 
lspci when you hotplug it?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
