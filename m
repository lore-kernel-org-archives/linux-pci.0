Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62951 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab2JaH1j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 03:27:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 08/15] SPEAr1310: Add PCIe auxdata for miphy clock initialization
Date: Tue, 30 Oct 2012 21:57:35 +0000
Cc: shiraz.hashim@st.com, viresh.linux@gmail.com,
	spear-devel@list.st.com, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, olof@lixom.net
References: <cover.1351492562.git.pratyush.anand@st.com> <06c4b001f57084702b42a66565248ae871b909bf.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <06c4b001f57084702b42a66565248ae871b909bf.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201210302157.36153.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 29 October 2012, Pratyush Anand wrote:
> Miphy Clock initialization is very specific to controller and its
> instances. Pass this custom function using auxdata.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  arch/arm/mach-spear13xx/spear1310.c |  148 +++++++++++++++++++++++++++++++++++
>  1 files changed, 148 insertions(+), 0 deletions(-)

I think you shouldn't have this in platform code. I don't have the full picture here
but it looks like it could be a separate clock driver so you can use the regular clock
functions. Platform data with callbacks is not acceptable here.

	Arnd
