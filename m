Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7F3FBA7;
	Mon, 22 Jun 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147811; cv=none; b=nWX5T65hqQQI9MxtQyMesnx+VPciUCAUbQYdwVaw4H2utuIIGuCgBuB2/NR7pqQBqQf0SPnawTUqnXGFq0UZQpCKtfC3gX6+ugetfCUs1EO6Bh345eGTyocyCHGJUFfFQZack/BzM+DcOmtg9ERyZPoNv10ANsCy5MWSPsMujwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147811; c=relaxed/simple;
	bh=4OhlDdOoVBOJ3ghoxn7efGU6Oj+BF7UgR9f8xyNU8T4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IJ0ldPw4dKePO6kVtY9uvlp7qR03/++qU+mLsC2fLA1uajtx6YGM0H3m8V/oP6Act6rbPNY9DF3IG+0umxwDt4IJWyoIIa4B6sHLjxgFRlqecJtliAlrTriknxKIWIJcIUm11smDTRMI9RDOQsi+73Rgn2mpN99p449QHq2xWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIUnBer4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIUnBer4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF071F000E9;
	Mon, 22 Jun 2026 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147810;
	bh=kkJ/wtEJRdK2qA8AHpuF9QtgBjJ5DYvtxf6537ftZlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BIUnBer42in7dNJb/45GkhJINrlIfubwYEagyB8t/RBo+ktgFxlsL532/JY6+y8ul
	 biUtFyX/D39OgVvje918kxIXwO0J6Ms7e8LD2TPMhkfx6P7wXRWpFnMV+fIhOygVG8
	 0kr6pOjgTs/jeBBvp0oP9zBwrD8OU3qKGYryvlZHrY56Xi00zDuFBS5HoLxwSbH4wz
	 0CiLbJfi7/wUJmHscHejtLGC461pn/xfdu803r3DUJybkyLUvfAOWkXb0+/2AB6DBJ
	 Ndy6a1vBb/7K1z2QzPliEt4PnnUy8GuslzgBtrzwLOIgKOs9LFinzPBV56ruYLB2vj
	 xqtWY4Gp6WObQ==
Date: Mon, 22 Jun 2026 12:03:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Darshit Shah <darnshah@amazon.de>
Cc: bhelgaas@google.com, Jonthan.Cameron@huawei.com, darnir@gnu.org,
	lukas@wunner.de, feng.tang@linux.alibaba.com, kbusch@kernel.org,
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, olof@lixom.net,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v3 RESEND] drivers/pci: Decouple DPC from AER service
Message-ID: <20260622170329.GA675275@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai8h-wyXz8l30X-V@dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com>

On Sun, Jun 14, 2026 at 09:54:17PM +0000, Darshit Shah wrote:
> Hi Bjorn,
> Can you please pick this patch up in the PCI tree for the next version?
> Anything I can do to help expedite the process?

Sorry, I missed this and I don't want to add new changes right now
since we're halfway through the v7.2 merge window.  Can you ping again
after v7.2-rc1, and we can make it v7.3 material?
