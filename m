Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0149DB8E
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784683; cv=none; b=E8GxOls37cv4EgtSAWIS4hcRL1rpv2ZUHWwqeOe3VPd3lB/syTH2kYefGn6yGbfgaBA+DPDsu0RgyqoScXaLgghJrCeHA6jfhmdwKJDbJlPFFP6hE3YoHwcK2W/iZv+SFRKAPYO/8NCmuUbvgr0Ne0XqJVq/VCvrVy51og0Q5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784683; c=relaxed/simple;
	bh=Yipk1ORgpEK4lWUygccfKdYuUNAF9+2GBATDL2SJsz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pNRF2LM2eid4y/OBaSBDRnHnG5evKL101jkl6Nb9iwgaNhwxx5ZzM9uZb/Dkm65YMCW2A6o/eC667bawawfGfVXiatL1YiXnBZBVBTex0OJpIcUuQuC8AXij2Lk4/Jvdy9ZndbiNiJ9JAqEboP9A98dIUoiKLs2g1gwM6KcJc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DDD3092009C; Mon,  7 Sep 2026 14:31:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D83FF92009B;
	Mon,  7 Sep 2026 13:31:56 +0100 (BST)
Date: Mon, 7 Sep 2026 13:31:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: M M <restafvalendergelijke@outlook.com>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "andiwild@gmail.com" <andiwild@gmail.com>, 
    "bhelgaas@google.com" <bhelgaas@google.com>, 
    "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3] PCI: Bail out of failed link retraining when the
 Target Link Speed is already clamped
In-Reply-To: <DU2PPFBE35756D1899C6C3A534F909D7840ABA82@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.2609071331100.46717@angie.orcam.me.uk>
References: <DU2PPFBE35756D1899C6C3A534F909D7840ABA82@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 1 Sep 2026, M M wrote:

> I'm reporting field data on this issue from two production machines, in case
> it's useful for the patch.

 Thank you for the report.  I'm back from holiday today and will review 
the situation in detail in the coming few days.

  Maciej
