Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:45156 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932142AbbDUUBY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2015 16:01:24 -0400
Message-ID: <1429646479.31675.6.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Mohit Kumar (email bounces)
From: Joe Perches <joe@perches.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org,
	Patrice Chotard <patrice.chotard@st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Maxime Coquelin <maxime.coquelin@st.com>
Date: Tue, 21 Apr 2015 13:01:19 -0700
In-Reply-To: <20150421194625.4792.69968.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150421194625.4792.69968.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-04-21 at 14:46 -0500, Bjorn Helgaas wrote:
> Email to Mohit Kumar <mohit.kumar@st.com> has been bouncing, so remove the
> address from MAINTAINERS.  Let me know if you have an updated address or a
> replacement.

It'd be nice to add a CREDITS entry if Mohit has
really disappeared.

Either that or CREDITS should be deprecated or
deleted now that git log information is pretty
comprehensive and contains 10+ years of data.

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
>  PCI DRIVER FOR SYNOPSIS DESIGNWARE
> -M:	Mohit Kumar <mohit.kumar@st.com>
[]
>  PCIE DRIVER FOR ST SPEAR13XX
> -M:	Mohit Kumar <mohit.kumar@st.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/pci/host/*spear*


