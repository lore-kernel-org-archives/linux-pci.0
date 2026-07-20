Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3A417D71;
	Mon, 20 Jul 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550718; cv=none; b=ekNK/KWNg8Il/uVfZX28hDB+PgxlLyUE0kzgKNezhYBV6hadIrt1/PGvtyvH7x3bvv3K7RbHoNtIwMseOZ3heOw7gexRL50QmLtTeFcLRvkznpf78SOdLgqwzVZNsLZLWFEfn6QYxiL3jo3VConqUtJ5WYQATSPuDJeXjlj/YK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550718; c=relaxed/simple;
	bh=mpzeQFeBiZtBhhEHtYlPNFCKYBTEvp7YO2yAx1Er92o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBRgUft0IDGjfSCdcOONkEMe1oIPb+0fXxgAN4rcAbWnbGdNBQ6B7mIIF8gcRhNrCZztG+tCNNuilh5KvKS5aDpfjM20SzuLyJeSidoCUHznvCCNOCdr28ND8UVWVjmxEU/KcqRxY+DSwSzwUno9+3FwoetVrkO9uC3lULlcL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=rOiZ/TDN; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="rOiZ/TDN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1784550093; bh=mpzeQFeBiZtBhhEHtYlPNFCKYBTEvp7YO2yAx1Er92o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOiZ/TDNVYhrYWlHPrF4vSoQjuhgrl8oQCOhNZSl/8jcZyMJSJYa+irgnfSe/G2d9
	 K0KssMuPsJtQHjl3muCZi3beTLlP600jcWK89EtM8k1svtVJGpUIYPf0siKsMeRpo3
	 ae96Id6W9cEOn3Z+6MCMOTuxeM/XrhjZCb9sjN48tkyp2F+aSFyKJJ/pwzJz/34Xs3
	 +TYnMljB8pAgRmY7z/O5i3pehQvoDmUQHonI8wLwWHPgCHg6KbXZL3VyT2STE2XvAu
	 aB+9UFWdtSBrBnqvMj+JzTLfZzzxhfHKocZaenXaUVgtu91NQC1wqyCulC5+k6t2/h
	 ApXF3UxNlgudA==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4h3fkz14Dpz3C;
	Mon, 20 Jul 2026 14:21:31 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Mon, 20 Jul 2026 14:21:29 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Uwe =?iso-8859-2?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Keng-Yu Lin <keng-yu.lin@hpe.com>,
	"Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Alexander Graf <graf@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?iso-8859-2?Q?Wilczy=F1ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Akshay Gupta <Akshay.Gupta@amd.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 12/12] misc: Unify code style for various *_device_id
 arrays
Message-ID: <al4SyY2G8eD5O9Ms@qmqm.qmqm.pl>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
 <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <583653bc7b9ae19707bc28be69a20e66b8c3720a.1784299069.git.u.kleine-koenig@baylibre.com>

On Fri, Jul 17, 2026 at 04:50:58PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>  - Add a trailing comma for initializers unless the closing brace is on
>    the same line and for the list terminator;
>  - Use a single space in the list terminator;
>  - A space after an opening { and before a closing };
>  - Use the PCI_DEVICE* macro in two drivers for pci_device_id entry
>    which is usual for these arrays
>  - No explicit zeros in the list terminator;
> 
> None of these changes introduces changes to the compiled result.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
...
>  drivers/misc/cb710/core.c                     |   5 +-

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
