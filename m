Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068D40B37A;
	Tue,  1 Sep 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275739; cv=none; b=Eh+bznwyVTwnyOT+JK8lkdmxEQTudsTEdBt+amtJIAKHydB1CNWNCj5ZhLC0UqHHtdkm42Jp17AqMiPh8zqT5e1+gcmx7cMI67275LrgMlhxbELgBmMcyWyI6nLPLfGrAg5C/bIvm1VBt8v1x7y4FExLiO2Iv6+BQ+m3n0dpvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275739; c=relaxed/simple;
	bh=1NbyUXv0y9/mIBwllTSOW9smAeFze/9XvrrEscJitE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfw65gzTycpJyU0znnCUdr1f+PLbwNajmCN8ltZ3gMORJg1CxqGOiyXxaJ9t98m2ZZKSAaOZ9BpvEgPH89DW0fxqoUEUdSoPS+afypkEdR8Z89q4P7DaEzZUzMWiZAl2haqitd8SM6K03zkoXwiRxhlh+GCdB5CgXtfyWeWxtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SvL8VRGs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SvL8VRGs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0C9AC4E414A6;
	Tue,  1 Sep 2026 15:15:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D27646053C;
	Tue,  1 Sep 2026 15:15:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6448D11C78015;
	Tue,  1 Sep 2026 17:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788275733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wnpui/mds3qSH7SsIIBvw4DEtDzwvrHoFad7QDsp53A=;
	b=SvL8VRGsIDGY7PrwGDkFeJnuoy69gZgYyH6jlKtqztdVKyM4tfVLt/DM7FtOd8uwqCRoBV
	0zzNT/kFe/LW5COa3E7rhOE7mWBHpngzGKASthvqDmb3QpQFnEttqpZK3uI6PVKxh4Hce5
	WtXgR6fFHPHF4v4lxumtSGOvXzwu5CVvx1IqmNkHyQm9ku1IXfyr0rJb6Mg/mhEqViu1Ro
	6j19jkZq07DhwyS4mkhs5j8bwhNUs3qSPnjcSG84h3YhWcY09X4joE3m8m9eeG0K7gmQv4
	/5rKuuXMs6WZDyF+l558AoSifxeGjzHiXu6iT8BqLJq4hqZ6HWu8jmoASKMbkQ==
Date: Tue, 1 Sep 2026 17:15:28 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, robh@kernel.org, saravanak@kernel.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] of: address: kill of_node_is_pcie()
Message-ID: <20260901171528.487ca48d@bootlin.com>
In-Reply-To: <6a5bec41-71ef-4d9c-a34f-77d166b15ca6@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
	<20260901011338.1323243-5-elder@riscstar.com>
	<20260901084546.424c6ef2@bootlin.com>
	<6a5bec41-71ef-4d9c-a34f-77d166b15ca6@riscstar.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex,

On Tue, 1 Sep 2026 09:58:10 -0500
Alex Elder <elder@riscstar.com> wrote:

> On 9/1/26 1:45 AM, Herve Codina wrote:
> > Hi Alex,
> > 
> > On Mon, 31 Aug 2026 20:13:37 -0500
> > Alex Elder <elder@riscstar.com> wrote:
> >   
> >> The of_bus->match function for the "PCI" bus type is fairly liberal
> >> in what it accepts as a PCI bus devicetree node.  If a node has no
> >> device_type property, it even allows a node named "pcie@" to be
> >> accepted as represnting a devicetree bus, though it issues a warning
> >> in that case.
> >>
> >> A recent PCI commit introduced of_pci_verify_node().  When a PCI
> >> device is added, if it has a devicetree node, that function checks
> >> its device_type property.  For PCI bridge devices, if there is no
> >> device_type property (value "pci"), a warning is issued.
> >>
> >> That warning duplicates the warning made by of_node_is_pcie(), and
> >> there's no point in that.  Avoid the second (OF) warning by just
> >> checking the node name directly in of_bus_pci_match().
> >>
> >> That leaves of_node_is_pcie() unused, so get rid of it.
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >> v3: - Added (new) in this version of the series
> >>
> >>   drivers/of/address.c | 12 +-----------
> >>   1 file changed, 1 insertion(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/of/address.c b/drivers/of/address.c
> >> index 499d37ceae210..ee2eb44884d85 100644
> >> --- a/drivers/of/address.c
> >> +++ b/drivers/of/address.c
> >> @@ -134,16 +134,6 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
> >>    * PCI bus specific translator
> >>    */
> >>   
> >> -static bool of_node_is_pcie(const struct device_node *np)
> >> -{
> >> -	bool is_pcie = of_node_name_eq(np, "pcie");
> >> -
> >> -	if (is_pcie)
> >> -		pr_warn_once("%pOF: Missing device_type\n", np);
> >> -
> >> -	return is_pcie;
> >> -}
> >> -
> >>   static int of_bus_pci_match(struct device_node *np)
> >>   {
> >>   	/*
> >> @@ -156,7 +146,7 @@ static int of_bus_pci_match(struct device_node *np)
> >>   	 */
> >>   	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
> >>   		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
> >> -		of_node_is_pcie(np);
> >> +		of_node_name_eq(np, "pcie");
> >>   }
> >>   
> >>   static void of_bus_pci_count_cells(struct device_node *np,  
> > 
> > The warning here was printed based on the node name whereas of_node_is_pcie()
> > prints the message based on the 'device_type' property of a pci_dev node.  
> 
> You're right.  Both warnings were getting reported for me, but for
> different reasons.
> 
> I would be happy to just drop this patch and live with two warnings
> in some cases (we should rarely see either one of them anyway, right?).
> 
> Is that OK with you?  Does anyone feel this patch should be kept?

On my side, I have no problem to see two warnings and so, IHMO, this patch
can be dropped.

Best regards,
Hervé
