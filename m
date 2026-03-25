Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972E3126D7
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463383; cv=none; b=DsBStWDpbguHCSIuEONwMfvjnJyFT3E2f23CDMn+j0aEKTgohJY+PsJmdzC256CtadTY5i189UcUCbw3hO38GmVz4gprVQ1dsAV7r4Ymugjg+PtLyFRt3jy0tvLa4QtIWFRxEm2NvAPZ+/6lFANNdtDs8LekM2DCOQ4Lil34L3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463383; c=relaxed/simple;
	bh=966frQpB0Xm9H/0AdYnqSQQxIaoxgv3Ygysz2Iqg460=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k5/RLL7N+5mgcyH45tu0r3/ga9ybsNCdApoURPnWr8D8GOKnBf2xnuk1Cen90HM+qfpKbxCqTGOH6sFddjEsaxzt4ssQHAGZaDWoMwNsB5ZoVqMQp+v8EgXH9upX0RwM2YdU7S8aWJ6ni4LrhQzV0ljYFE/Sm00qadZtu3nrJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5l+Ee0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5l+Ee0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF88BC4CEF7;
	Wed, 25 Mar 2026 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774463383;
	bh=966frQpB0Xm9H/0AdYnqSQQxIaoxgv3Ygysz2Iqg460=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e5l+Ee0R3CieZrRr0oTRo8YO6Qki9lHTFUDxUxECwLN/Xs6AOrhfkH3AWjGfkIY57
	 VfloT6LBSYi7W/+k1YXBZV8CiQahvo5g/fStJwcg/suq0XyQ3/MjNGrOKk2S4ccIB2
	 EzTuT9BCmg1N6WX1rLoWUQPgZE1m4tAFRJ8H/Z9VjgGlflWpHVWKsxRFlZDECAosMI
	 Wm8pvApYCW1mYDLCHO54o3+rB9972XVuOPV58ieFl3zZ/GcTXcBReQiRjNd3bOguk3
	 aVIKYpjgoJZuGmGvfPTZZjAq0pvrqwb0b93beGSMdPgSctXojpnqfzY5zmO0rQMWhU
	 6bodlR/eyf10w==
Date: Wed, 25 Mar 2026 13:29:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/5] vgaarb: pass vga_get_uninterruptible() errors to
 userspace
Message-ID: <20260325182941.GA1196515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005254cb-6070-488d-a548-9ac10df568a9@hogyros.de>

On Wed, Mar 25, 2026 at 03:52:37PM +0900, Simon Richter wrote:
> Hi Bjorn,
> 
> On 3/25/26 4:37 AM, Bjorn Helgaas wrote:
> 
> > > If VGA routing cannot be established, vga_get_uninterruptible() returns an
> > > error and does not increment the lock count. Pass the error on, and don't
> > > call vga_put() when userspace closes the handle.
> 
> > I applied this, but I'm a little confused about the "don't call
> > vga_put() when userspace closes the handle" part.  Does that happen in
> > this patch and I'm just missing it?  This patch changes the "lock"
> > case, and the only vga_put() call I see is in the "unlock" case.
> 
> By not locking, we're not incrementing uc->io_cnt and uc->mem_cnt, so the
> release will not call vga_put().

Thanks, added this to the commit log:

  If VGA routing cannot be established, vga_get_uninterruptible() returns an
  error and does not increment the lock count. Return the error to the
  caller.

  Return before incrementing uc->io_cnt/mem_cnt so vga_arb_release() won't
  call vga_put() when userspace closes the handle.

