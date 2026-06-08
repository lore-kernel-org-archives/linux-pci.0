Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD53D45FA
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937501; cv=none; b=KPWlMidApBdrBYGhmAVpHpXHPYrBtcnMHXWp7LMuUYSIpny//3zMpI+hLXiVg8sb5UxyWhD5FDTKcy3NlxRW4KTXYf2HRYAb7hOy+gkkHor52z4aIIGyrmZKh6zbCneTzHPQSvsk5BKnlbpZD5pd+e0CCyWwsJE31Oh0L/A+uEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937501; c=relaxed/simple;
	bh=ar28/s3JG2fowVQKqZqkTS6799z9s83mIjsqEYMmYOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIC6PEagPH9T4N3qtAQAFp4NaMMk6iQZlGvCeVFUxJu3KKmp1GRX85xnzqxFYyJjvrYdH8corzueb2+2z4BK6jnvI8EJcA+8TSjVinGI/yxgSB2aTcZZDgmLyss8SyBpx57cfxRh1qgza5ZHLnBYSbTUJCl5pO9cPopEDqcjOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqWIJDnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqWIJDnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A566C1F00893;
	Mon,  8 Jun 2026 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937500;
	bh=hCqk/GnnFAb5hDQyED5zwb6pXr2GRoHU0WRcgx7aWLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SqWIJDnSjuMylw5lb8s/tiYcJ5fkWmZ6Y0L3m1AJ5oGRo44MrsVGVQFUFJtLGRDqa
	 JRZ8r03jEhr2s4uNhUar9pO+oZ7GwhqcJbNGgkAhV941F7/D2oKGx1tBwyLknn30rA
	 +RVAxQAbdDv2pcsD4UjvWmUiHLq+BZhtzwJBcavJw42tQZFMPDDQWKNkdHmbl6lV+g
	 lrMRREc1lyDIzD0oCqKfvhVaH+cyuM8gzhzvIrezJbD63y85cS83dSXsnex/79PfJh
	 jmsKgf2c9Fdeo6gZBEcToycAxhkFi/N7VrJZJoZcDLVkIwKfMiFCKtBhwdFaU1XA2d
	 XhGTdDxhyfD8g==
Date: Mon, 8 Jun 2026 22:21:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
	nirmal.patel@intel.com
Subject: Re: [PATCH v4] PCI: vmd: Add feature to scan BIOS enumerated devices.
Message-ID: <hqcwvmh2kz6sxx4udassaatuwc3foc3v6j7stekpsdbiipmrj7@swazc3hukadc>
References: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
 <20260527120139.00004254@linux.intel.com>
 <20260608073320.000035a0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608073320.000035a0@linux.intel.com>

On Mon, Jun 08, 2026 at 07:33:20AM -0700, Nirmal Patel wrote:

[...]

> > Gentle reminder. FYI, I also addressed comments from AI review.
> > 
> > Thanks.
> 
> Gentle review reminder.
> Thanks.
> 

./scripts/get_maintainer.pl drivers/pci/controller/vmd.c

Nirmal Patel <nirmal.patel@linux.intel.com> (maintainer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Jonathan Derrick <jonathan.derrick@linux.dev> (reviewer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Lorenzo Pieralisi <lpieralisi@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
"Krzysztof Wilczyński" <kwilczynski@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Manivannan Sadhasivam <mani@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Rob Herring <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Bjorn Helgaas <bhelgaas@google.com> (maintainer:PCI SUBSYSTEM)
linux-pci@vger.kernel.org (open list:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
linux-kernel@vger.kernel.org (open list)

You didn't CC more than half of the above entries. So you can expect the patch
to fall through the crack...

- Mani

-- 
மணிவண்ணன் சதாசிவம்
