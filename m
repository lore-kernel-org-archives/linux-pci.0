Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4935 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbaDCPXR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Apr 2014 11:23:17 -0400
Message-ID: <1396538590.3215.6.camel@ul30vt.home>
Subject: Re: Writing to BARs of PCIE device
From: Alex Williamson <alex.williamson@redhat.com>
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Date: Thu, 03 Apr 2014 09:23:10 -0600
In-Reply-To: <CAHH3p5LwsWqtK_RhaYNKi_HeNYH3EHrgXV21SbRTA4mm2Vyjwg@mail.gmail.com>
References: <CAHH3p5LwsWqtK_RhaYNKi_HeNYH3EHrgXV21SbRTA4mm2Vyjwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-04-03 at 20:38 +0530, shiv prakash Agarwal wrote:
> Hi All,
> 
> I have a stress test which write a specific 4B pattern to whole BAR
> space for all BARs of a pcie device.
> 
> Query is:
> 
> 1. Is it allowed? Or will it have any side-effects?
> 2. If No, is it not allowed for all BARs or some BARs only like BAR0?

Of course it will have side-effects, it's conceptually the same as
'cat /dev/random > /dev/mem', but for a device instead of the kernel.
What you're overwriting is device dependent, but in any case you're
trashing something.  The test sounds completely invalid to me.  Thanks,

Alex

