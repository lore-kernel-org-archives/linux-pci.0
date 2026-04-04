Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5A223DCE;
	Sat,  4 Apr 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775298630; cv=none; b=bfMBUCExLcsPuMzSE8xaF++E19wFBSA0kvJvGqfFp9tC5Tkq7F4bp0iWu9bRKVc+fvDyKEOCvCmBhgvTfuGgJTo8WC0lVpbfKSc2bOoQxzBG4HWRIIaEeDPKAp8NP4p+TFYmzTzBqfrUhzdOXC9oAmpF0Q4fgCWvxF4OHssLwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775298630; c=relaxed/simple;
	bh=kai1nLeYazfnWE+JN5kZp2zPsQl3Q7S8fv6gHebZsrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4axv8QvfpCLXl7MdOVLWeOfArG1ggZohVgx+BdglKU+7eGYblOArD89n4iWZMzzhb7eOjddQ5AJP4TbrHpquqV5vyCTT6/SvggzJLTkndY1t+q3+9URr1yHLd8cvKsRFyzaoo2HKBn2HpgTuP1++wtcqqsayP+3fWB9Qslc5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geUpICR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geUpICR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF548C19421;
	Sat,  4 Apr 2026 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775298630;
	bh=kai1nLeYazfnWE+JN5kZp2zPsQl3Q7S8fv6gHebZsrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geUpICR4a6zMprcqjk1FzfII4qN5EeAACL693fY+UBe+m9X+RVjA+Wn2/XtVgr7WS
	 GFHAQwpTH1aB07NbR7JuHAi3nx4i4b/wDxYlAsdPPOE9BA4u795I6S6esMdUlP8u5x
	 TgH+0kU3XVKyl+zQkk9emZThwZrLcKVVoqL/OmIsJfkIwKwTRDFAVa/DbfIjG1iu3c
	 p4/L1R8f5SrvEOG4+OXrEeum68pOnglP4HE4zO3eh899anfzhFwmCoTvbFczrZnTmU
	 CApsuJCxWMvvcdSoGEhHUGkWqbMn4jf9rNBPgr2ut1waSD1EdIHE1JYaARDYMN7g9S
	 lENqI8yI+D8bw==
Date: Sat, 4 Apr 2026 16:00:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, 
	Niklas Cassel <cassel@kernel.org>, fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Skip subrange map tests on DWC iATU allocation
 failure
Message-ID: <kuyfi33yxylz5l6hruq754hr4243xhrpa7rzpu3phvj7xomn2y@ya6ttuo3ueby>
References: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>

On Mon, Mar 23, 2026 at 12:59:26PM +0100, Christian Bruel wrote:
> For platforms with a limited iATU inbound window entries, pci_epc_set_bar()
> might fail to allocate the ATU entries for subrange maps requiring more
> than 1 slot.
> For the dwc controller, this failure is reported with -ENOSPC in
> dw_pcie_ep_set_bar(). In this case, the epf test cannot be run and needs
> to be skipped.
> 
> For other controllers (Rockchip, RCar, Cadence) the .set_bar functions do
> not use this error.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

Could you please respin this series on top of pci/endpoint branch?

- Mani

> ---
> Changes in v3:
> - Remove 'BAR' from SKIP print message (Niklas)
> - Added 'Reviewed-by: Niklas Cassel <cassel@kernel.org>' tag
> - Link to v2: https://lore.kernel.org/r/20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com
> 
> Changes in v2:
> - Rebased, reordered patches
> - Clarified reporting message in selftest
> - Renamed STATUS_BAR_SUBRANGE_SETUP_NOPSC STATUS_NO_RESOURCE
> - Link to v1: https://lore.kernel.org/r/20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com
> 
> ---
> Christian Bruel (3):
>       PCI: endpoint: pci-epf-test: Handle -ENOSPC in subrange_setup
>       misc: pci_endpoint_test: Handle -ENOSPC in subrange mapping test case
>       selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC
> 
>  drivers/misc/pci_endpoint_test.c                         | 3 ++-
>  drivers/pci/endpoint/functions/pci-epf-test.c            | 3 +++
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> ---
> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
> change-id: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92
> 
> Best regards,
> -- 
> Christian Bruel <christian.bruel@foss.st.com>
> 

-- 
மணிவண்ணன் சதாசிவம்
