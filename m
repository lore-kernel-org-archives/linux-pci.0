Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6833F5A3;
	Mon, 23 Mar 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261324; cv=none; b=ga9S+8hRVeFEgqCXI7gOkdwQI150ntYEmnZrMQtY/xd1vTmlRqKOTnKjncI+Li9kkEw35fGlQbrsvQhriSKpwIPFZhviqw1Li+CbSwNW4oTNrxgZG3sLpxTMsNF0QAnq3tx5t2n864zPZBljDhsdo0UdPmqUvp+wqmxU1DiL0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261324; c=relaxed/simple;
	bh=xRCLkkqt2w9tLuO9uqOfKDgYUNnNYifYdvkbA2zzmDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiCPi9Djdf39aJi+CGuE1gWj/xbJ1CIJ36ggZTGOmG5mdu4ZEBgg8Twi+jYFdj09njwRmWgSJ5T5ZdvuA1h41xcln5LfDdWR1SBk6OJ6iNNABnPIqO2jy9IKpNdr82DnKu1ZTd7dcCjTRY3gNWNi7GE1gUzhC8w6kiO9SonDlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff7L4jdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff7L4jdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0894FC4CEF7;
	Mon, 23 Mar 2026 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774261323;
	bh=xRCLkkqt2w9tLuO9uqOfKDgYUNnNYifYdvkbA2zzmDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ff7L4jdKK0q1oSsH1czcl8SboT0a/dz7UdqHfhc923xNZT16+8gRWdoQLiH5BekZ+
	 vyNcfe0xVXsVqfGou5XjCA+srSh/Xkr1rQcT5nmtWlp7w/bg79WD3A1Ivp3etNfhNe
	 uAxgmcgGz5cOkY1CobZO4RUDGWvQYk5+7VPrb6EJx+eUHfHIIVo6gt3ZrbnH/Qe5LO
	 y9uAY8PXRYr6lskG+i1fIpTrO4GSf3EI0QqONoJHBTIcJKFNtuY0hOOJEA5sqfSC7h
	 L0Be1/8rY2xO0C2LT0Gv3VyTdhJmvMtJ3I6rtUkJ60Y4U7S/5B0ywNyFE6wRiQnzYu
	 4bGgCjSn6FYRw==
Date: Mon, 23 Mar 2026 11:21:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in
 subrange_setup
Message-ID: <acEURus0OoDYP-Du@ryzen>
References: <20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com>
 <20260323-skip-bar_subrange-tests-if-enospc-v2-1-2080f878134d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v2-1-2080f878134d@foss.st.com>

On Mon, Mar 23, 2026 at 09:15:23AM +0100, Christian Bruel wrote:
> Set the STATUS_NO_RESOURCE status bit on pci_epc_set_bar() -ENOSPC.
> Here this is used to indicate there are not enough inbound window resources
> to allocate the subrange.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
