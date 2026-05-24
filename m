Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5D3597B;
	Sun, 24 May 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779592537; cv=none; b=RXUXDAuvi3B6yaCm2DvWZ5tGGEnJ+NcbbIBMyFsbF799Lu5i1W2tSogSf2QS4+aGQgOuXSP4aK9Ox7sbOCklvM3o/ME1MtZkK0g28A7uk3SGEEMaND/eHZx8rEw0GHJHyS3bzbubXGH5OeZ9aOmDgi4SfBASll7oJKSPpq6/mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779592537; c=relaxed/simple;
	bh=tQRCUE74N9kr441zpfSCo29VuguijEAuqrA6Shp4D1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoZ2zR9feXFO9byJFBwbuuEjWMg3DBy/O4Wcjk0CYR8EzEEHm88rxe5gVFzZZ15H7TIOLnIwRFysA88Q7xr6UYnsGa6vj/JYrnvPqj6hL2p2L4nd+jG3ZA9ZkCCac4vH5zFfWCcuDDyThEdjb3RDYn17+RUfSf5Zk2s83VCRpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyiTVidF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyiTVidF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38941F000E9;
	Sun, 24 May 2026 03:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779592536;
	bh=pst0KhGvs6xW29Av8Jhi5H/6qnNY65bQbAF4WiBIsl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cyiTVidF5bPSqKeDx1f4mqrPQPNWIT/mJDCrF5TA5xjrodQ1sIlFITf9b5CwbAJSY
	 XezynYuzkRRw+xAhIJsl2m4rw+1ypY4CUfHxNf28jEAACP8VMzHJ9SDRKdm9GnMmqi
	 vc9xl7Zrf3jrxQrKu3goPDiCIYs24z/p7pOAWjlHfwxWU3tYnWvGIgN/f9SckrNOIX
	 HK9X+j22FUu6dLkI2wHNJfS9D0GPX7QLL93c2A7JvUv2LLh7nUJTr1nEA3L4cvykLf
	 ZQ+zt360WbGbvhZLnjXzEAZojPSlqaJTCHR2KEamU8ULEH5uvUjF596S+wKHU4xTQT
	 2VyGR12CfVLEw==
Date: Sun, 24 May 2026 08:45:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1] dmaengine: dw-edma: Remove dw_edma_add_irq_mask()
Message-ID: <f6kwerrf2x7n7iy52mprq5zhqikzpdqbl5anzkrutvlyehix4w@ffks4f22nmme>
References: <20260521100640.3333076-1-devendra.verma@amd.com>
 <3o7rek4lwnp7saci44acwxdxfhr2w2hd72feofcl3gipbofcjv@iazqkn57gqvl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3o7rek4lwnp7saci44acwxdxfhr2w2hd72feofcl3gipbofcjv@iazqkn57gqvl>

On Sun, May 24, 2026 at 08:44:00AM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 21, 2026 at 03:36:40PM +0530, Devendra K Verma wrote:
> > Function dw_edma_add_irq_mask() is not used anywhere. The
> > output of the function is not used hence it is redundant and
> > can be removed safely.
> 
> Where is your s-o-b tag?
> 

Also, if you had used scripts/get_maintainer.pl or b4, you would've added
'dmaengine@vger.kernel.org ' list to CC.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
