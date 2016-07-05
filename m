Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35592 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcGEQXN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2016 12:23:13 -0400
Date: Tue, 5 Jul 2016 11:23:10 -0500
From: Rob Herring <robh@kernel.org>
To: Pratyush Anand <panand@redhat.com>
Cc: dongbo4@huawei.com, bhelgaas@google.com, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, Joao Pinto <jpinto@synopsys.com>,
	open list <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] pcie/designware: Keep viewport fixed for IO
 transaction if num_viewport > 2
Message-ID: <20160705162310.GA23531@rob-hp-laptop>
References: <cover.1467647958.git.panand@redhat.com>
 <687a0706f69f6ebea047441aba5231113fd0c898.1467647958.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <687a0706f69f6ebea047441aba5231113fd0c898.1467647958.git.panand@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 04, 2016 at 09:44:42PM +0530, Pratyush Anand wrote:
> From: Pratyush Anand <pratyush.anand@gmail.com>
> 
> Most of the platform have 3 or more viewports. We do not need to share
> viewport for such platform between IO and CFG. Assign viewport 2 to IO
> transactions in such cases.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@gmail.com>
> Tested-by: Dong Bo <dongbo4@huawei.com>
> ---
>  .../devicetree/bindings/pci/designware-pcie.txt    |  3 +++
>  drivers/pci/host/pcie-designware.c                 | 26 ++++++++++++++++------
>  drivers/pci/host/pcie-designware.h                 |  1 +
>  3 files changed, 23 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
