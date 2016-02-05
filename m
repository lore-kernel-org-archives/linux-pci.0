Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47644 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbcBEWwH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 17:52:07 -0500
Date: Fri, 5 Feb 2016 16:52:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Vineet.Gupta1@synopsys.com,
	CARLOS.PALMINHA@synopsys.com
Subject: Re: [PATCH v3] synopsys pcie rc generic platform driver update
Message-ID: <20160205225204.GB11780@localhost>
References: <28b04a32cc7caf6db542d4b5aa1feddacd02b2c9.1454701564.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28b04a32cc7caf6db542d4b5aa1feddacd02b2c9.1454701564.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Fri, Feb 05, 2016 at 07:55:43PM +0000, Joao Pinto wrote:
> This patch tries to improve the host/pcie-synopsys branch including a new
> driver name, more accurate documentation and centralized link up validation.
> Other platform drivers were also updated to include the new centralized link
> up validation function.

It's true that I wanted you to incorporate a few tweaks I had made in
my pci/host-synopsys branch, but generating incremental patches on top
of that branch makes this too confusing to follow.

My pci/host-synopsys contains two patches on top of v4.5-rc1.  I would
prefer that you

  - fetch that branch,
  - make whatever edits you need, and
  - generate fresh patches based on v4.5-rc1
  
Then everybody can see the whole series at once without trying to
integrate these changes with the ones you've previously posted, and I
can start from scratch and apply those fresh patches on top of
v4.5-rc1.

It's good that you include summaries of what's changed between
versions, but if people want to see *exactly* what's changed between
your v3 and v4 postings, it's easy for them to download those series,
apply them on different branches, and git diff the branches.

Bjorn
