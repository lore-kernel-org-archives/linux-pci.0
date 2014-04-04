Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:59368 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbaDDQGX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 12:06:23 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so3645252pbb.31
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 09:06:22 -0700 (PDT)
Date: Fri, 4 Apr 2014 10:06:18 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mohit Kumar <mohit.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>, spear-devel@list.st.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 0/2] PCI: dessignware: fixes and cleanup
Message-ID: <20140404160618.GA9007@google.com>
References: <cover.1392904207.git.mohit.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1392904207.git.mohit.kumar@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 11:31:26AM +0530, Mohit Kumar wrote:
> This patchset fixes iATU programming sequence and correct some comments.
> 
> Changes ssince v1:
> 	- Change ssubject line with proper spacing 
> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org
> 
> Mohit Kumar (2):
>   PCI: designware: Fix comment for setting number of lanes
>   PCI: designware: Fix iATU programming for cfg1, io and mem viewport
> 
>  drivers/pci/host/pcie-designware.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

I applied both to my pending/host-designware branch, which will be rebased
and renamed after v3.15-rc1.  Thanks!
