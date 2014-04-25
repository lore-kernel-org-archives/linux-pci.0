Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60017 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113AbaDYIvg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 04:51:36 -0400
Date: Fri, 25 Apr 2014 14:20:49 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Murray <amurray@embedded-bits.co.uk>
Subject: Re: PCIE support as loadable module
Message-ID: <20140425085049.GB3168@pratyush-vbox>
References: <CAHH3p5Jib+ypEM0kUtRTn-qpfYCqw60fRKqjsNxbQpNTo+Zouw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAHH3p5Jib+ypEM0kUtRTn-qpfYCqw60fRKqjsNxbQpNTo+Zouw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 24, 2014 at 03:45:58PM +0800, shiv prakash Agarwal wrote:
> Hi All,
> 
> Can we support PCIE driver as loadable module instead of including it in kernel?

I think it should work with current code. But, You will have to keep
all PCIe device (ep/card) driver also as module, and they must be
inserted only after host (RC) driver module.
