Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E415C4014A2;
	Mon, 20 Jul 2026 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549144; cv=none; b=Cva6Xa/zwo0JSQUT9zVuRZxepQ+Lsvl4HInd8gmHqpM9OgFiUwSiIyg9L+wcN8XtRc3QreN5X/RLW4iM6GFY3SFi3EAh8x5UWa35MWtEre0+6b9W3dmESZxf1SdIf45qpc6O7pvzxcWuVI34SMaxP8RhAe6jUshCo7KzyGChsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549144; c=relaxed/simple;
	bh=ebMGhMLUwACYV5+X7+7eqn/A/ERvin32IKt5HwnEc7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLPgzCNXI27phrdxvBvMHw7fOpCN6vJScvGro3A6Bx15TzNYFxjA5Fo25uV37fVcBhh5MaZ73VF9kMzO2JJBQusK3bdzt6GjaYcueIROACzbmwApMZOHJ4kgsSkokI8/UwA6XYA1hlHJJ2977TzyrlyV2gOWWWV+7i+19c5v9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIAf6ccu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIAf6ccu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C3E1F000E9;
	Mon, 20 Jul 2026 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784549143;
	bh=C6Xy57Qw0q9RQatEQUzRbwleMCJ809bc3MA3CH+3eBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EIAf6ccu/qVGS4MuPqh2z0j96NOwkQvRwF48FkQOYHB7jXvCwvZ5nfQoI8h2DiPQT
	 p/3Ak+c4QDyy/qH9ih1ZtVBXwXzPm+5e78eoMO7iTYM2myM7S+BAJ5BPZZHI92ezgG
	 GVAuREG2iqLq8pVLv3urjBuCwPx+p8jT8LQh2OcrZ6ogRxBFa/KulHT5SaC1WqMer/
	 Bg3GVuNcQSZIt5Cjpa3SSqxQGqMsFA1BAWvoy8LT3kfy+X8MveNrzfCkasvRUifbtd
	 q/PfTl4BN46s+8pj4nDph9l+fbNXhjiRwbAmcFsYNtf9epBspCPJtTsqS0IOFt5+58
	 6XTIIeFdxInJA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wlmkf-00000008kDb-2LCp;
	Mon, 20 Jul 2026 14:05:41 +0200
Date: Mon, 20 Jul 2026 14:05:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
Message-ID: <al4PFaPEedf2iWcT@hovoldconsulting.com>
References: <al30lyKsG3ywkiJu@hovoldconsulting.com>
 <20260720110417.GA321880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720110417.GA321880@bhelgaas>

On Mon, Jul 20, 2026 at 06:04:17AM -0500, Bjorn Helgaas wrote:

> You're right, I'm sorry.  I used your original commit message.  I
> assumed this was for v7.3, but let me know if it should be for v7.2.

Thanks. And yes, this was intended for 7.3.

Johan
