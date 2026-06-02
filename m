Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21093BB66E;
	Tue,  2 Jun 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387242; cv=none; b=JlV92kKrMtZZd1nTY+iBqk7b0pXwDu31w4wAOrIJ00Uctgj6nX7NJnK+Jd4PaV4g2sm/ILkxlpzM/0yFDvFD8ou1twjVNsCkmaQozdZFtEdwwZNZwLF6jC4mE9G9WTTmis1HQc6XJfxAkkjUisTyrS8O5kPCeCLFUX9CbSg63BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387242; c=relaxed/simple;
	bh=7YH5a4BsQ7sxE9dgssCn6yyoCsJvShLjEllwLHhk2do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ56WzpW5VhrrOnd3QzqJXJP3QbmP+rlGUh0eZzbYRYrguYS2AwAOBAiATWXQ16B1YfkeAf2N3lw9pjg/p2MQvgThIkUEJFBesztr7iYQJIcDqEAGdoehvC+jFGcTL/eQjfKhSowizeFUmFPcaOdkdU81V5T2H7jKhYkgbfbK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU2jG8dS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU2jG8dS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780387242; x=1811923242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7YH5a4BsQ7sxE9dgssCn6yyoCsJvShLjEllwLHhk2do=;
  b=bU2jG8dSEN1zt6D3nCUtse+RhLax6uCjqSMPDTuDcWnCvqXQ/PQ2hUMm
   NAetLyfRrg58YyClOopT0dcRZrMttcv3LrIlEr5AIrIuQk0TWkvcxMerP
   mAO3MtiM9gDUzqhQmJxY3pYuDRrF+Oy2/k26aI9Vfz4UtyqBMRjvNsBzo
   y5eGBmB7pigIz9EQMgAxxytKR0ojNbr/lKeVNbi+ScZmmkF/u/t8cRiEk
   N7QRLbTlyhWSqINHlZAfnHTTISGzw/so9/80SMgETT9DMXQxXyfzAX/7p
   ez7IrQ+IckQwenxiWL7nMT15rWRjsQNcxABfOVTWwzuzVaHP0IiWtlDp5
   A==;
X-CSE-ConnectionGUID: sHy39HYsQDq+IhQqlUrigA==
X-CSE-MsgGUID: fLnbKpLsRiK3ScofdxX1/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80196200"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="80196200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 01:00:23 -0700
X-CSE-ConnectionGUID: KKI24J+ZRZqT9cST1kh6eA==
X-CSE-MsgGUID: SPRdFB9bQhKFZghWS9/tdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="248113655"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 01:00:06 -0700
Date: Tue, 2 Jun 2026 11:00:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof WilczyDski <kwilczynski@kernel.org>,
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <ah6Ng8u8bIKPdksg@ashevche-desk.local>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
 <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
 <ah3TN93e7lRpVihW@ashevche-desk.local>
 <20260602071311.gtvif43wcjyulphh@dev-vm-schuster>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071311.gtvif43wcjyulphh@dev-vm-schuster>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 09:13:11AM +0200, Simon Schuster wrote:
> On Mon, Jun 01, 2026 at 09:45:11PM +0300, Andy Shevchenko wrote:
> > Supported implies that one gets real money for the job. Is this the case here?
> 
> Thank you for caring about NIOSII. I'm doing so as part of my
> employment at Siemens Energy; if this is real enough then yes :)

Then Supported is exactly what a record in the MAINTAINERS needs and it
facilitates the existence of the code in kernel for as long as this kept
true.

-- 
With Best Regards,
Andy Shevchenko


