Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3619F438;
	Mon, 14 Apr 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652266; cv=none; b=YCu+3vCR/JO2XH1gLMlTnIwG0g7aFuJYmOyfOOhOaJqhFVIic54fU+L0VldOw6ulQwcIqPlNIURQeLRvRYqhz/jp/3bjluOvtG0xkF/EE+2WyOCEwGl4Ri0TieLP40G9DqRQUR6T3BHErliwlCOBRdnpKdmoyKtOfPI0ISBhSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652266; c=relaxed/simple;
	bh=6nda8t80VeHnplWw7cOTQ0UTPFtqO3gezNh36kUpE+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liOOWmt/cDWLrRTX9d1rCkXmR2kVfnYvgFVro0obWCvGd4PsjLo5floE+/8jwyt8Uy5DjU2EFP2BzmsYWIf9dNueEQXbdV2E7eKpdatwJcLq/fQfQotio58AmJjWhC1J+KYrt7nfZPimADwQNX05v1xdYQUEkPGyJEYI/GK/UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5n28Law; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5n28Law"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC902C4CEE2;
	Mon, 14 Apr 2025 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652266;
	bh=6nda8t80VeHnplWw7cOTQ0UTPFtqO3gezNh36kUpE+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5n28Lawu5oHuXuaTSXb614b/eOMLzQhwdeZ/o6UbGsa1srCWyqHEwOjKwpS9tcPj
	 bVWSFe/IrRY7RHYPoN/0xXWm2zVWdDuJOR2n0xoTpnFgjNxqZ+o2sKxh7qUURehlyr
	 9C6OliYKPtV8XzC4PMEuo45xnbf7MtgVa07jRH381KR4r5eF9iXgrbTAynFvG/M/t1
	 w1DEP0gRtSQc4mfQ5EubAZFYgc60Ag1rD3VEBFKX+5BwnFB+NNrlno2FnxFBo/bPlp
	 q4SabZeZmiGDTFTQqnE5tf+hEZ72KkEmSLvril1FsYzGSKUWgYBXUXiiNKJSQ6DwfH
	 o4uV8s2/OjdMg==
Date: Mon, 14 Apr 2025 07:37:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
Message-ID: <Z_1H6KkIt0YnkeLB@slm.duckdns.org>
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
 <Z_1E2z-l1xG--BSc@slm.duckdns.org>
 <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>

On Mon, Apr 14, 2025 at 07:34:51PM +0200, Miguel Ojeda wrote:
> On Mon, Apr 14, 2025 at 7:24 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Acked-by: Tejun Heo <tj@kernel.org>
> >
> > Please let me know how you want it routed.
> 
> If you would like to take it, then that would be nice. Otherwise, I
> can also take it.

Alright, applied to wq/for-6.16.

Thanks.

-- 
tejun
