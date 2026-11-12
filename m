Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494238;
	b=ss/7S4sjlK0oUXoacWI0gCjzWL5y1WAj6TKMvacsau1sOKUNr293A6Eyot8sleUqJdOh
	 OLKs0KUbOFvMeBNm6iDe4rgOwEpsoox6CGeZIMUxRTuqQwDjy9fQXCYmq0TxbqHeAJ7jG
	 xPhgBMy626rUO3ZzQ0DA1fsMeZ4s0oE3n/lVlpTRfgX7gphtXtne1GB3edKBmv1lRJTn5
	 cu1+rVUbs4talupUm4F0AawOUP3rKTukmRut6FpDNT8/7vxsDQ7rZX3Y64K0VU38UfBIb
	 JZ5nb7bY5nZRotA9U64xrztlnjJnQNKE8jnxbz5+VDeRx1zNjg2M8vVoAmqBTMBbhcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494238;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=DD/nG3awlkKAWlZMJekygG6yiGZOLCEaQyITg1YOWo8=;
	b=x+ONwnSMdW8dLpnr9IjWQHGpGa6RoRoYkkYAxTG093yHy/zC43MdYzGtN/XJVALaea8l
	 NT0xtcHAxxgoYLnWJnIaC3LNV+JID7Y9NPOlQLRc++eX7C+Gz11OHt1kIhwVtbwx8F2Xt
	 iRo2d4SIm9g4qv1B10be8B7a6GokS63JJKdIpIFwlhKZMO2QANkDf78kLOiFiY9Qn55nn
	 +aPP+hyecrYSUDoWmEseKXgwqsZ1jzVedfZQ7Ke3R+BozOV+5qHh5BCt9F01G8b7iH0R4
	 hk7ndbwzM8QGN9hcjeQEk8OmKywY3IM5Y6EFC98Le8AOBeLro/KJXP4tleR5gYzIrEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WakcJsTY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE3606A31C;
	Thu, 12 Nov 2026 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WakcJsTY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501BD1F00A05;
	Thu, 12 Nov 2026 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494237;
	bh=DD/nG3awlkKAWlZMJekygG6yiGZOLCEaQyITg1YOWo8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=WakcJsTYn0I8XZ7fHRYkFSmSxqGCWCIwxF3qsu4fHtHT6QXnlnktYan/6w8C1fjiV
	 ny8dcjZkdn1evtxFiqRpgGeaUGcKGyuFiD2S8ItWa3VkGuxi1kTy31ehRcicon93Jn
	 QoOt6IXX4P44KqqxwrdyN/yBK/kJMRvIFPcLRyxmHHeMzNdKfBjAsFh2MFSl7c2503
	 Cj55que/KM99XgYSvkWLIT5O55G96AL+bj2rfr8JmfRsDjXGoKCy6oDfs8rSzOAkFe
	 l2y6cztSM9jM5qlKIOjMg91uElLzHn8Do+g4VFtt0QKxFdquAnMAIKEwjIKIuLTtQz
	 6KpSdYHtovlBQ==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 15:37:10 +0100
Message-Id: <DMTB44YUT8RP.1TL0XPUEC4H6J@kernel.org>
Subject: Re: [PATCH 0/7] rust: treewide: remove driver unbind callbacks
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <johan@kernel.org>,
 <david.m.ertman@intel.com>, <iweiny@kernel.org>, <leon@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <igor.korotin@linux.dev>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <markus.probst@posteo.de>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <DMT4Y6N50BGG.3IEM84MO461ZY@garyguo.net>
In-Reply-To: <DMT4Y6N50BGG.3IEM84MO461ZY@garyguo.net>

On Thu Nov 12, 2026 at 10:47 AM CET, Gary Guo wrote:
> On Thu Nov 12, 2026 at 12:52 AM GMT, Danilo Krummrich wrote:
>> The driver model uses native Rust lifetimes, allowing driver data to
>> retain device resources and a bound device reference for use in its
>> destructor. Separate teardown callbacks are therefore no longer needed.
>>
>> Remove unbind() from the PCI, platform, auxiliary, serdev and I2C driver
>> traits, and disconnect() from the USB driver trait. Move the affected
>> sample teardown into destructors and update the driver documentation.
>
> unbind() has the `Device<Core>` state, which the destructor won't be able=
 to
> get. Are we sure we won't need it in the future?

Yeah, unbind() was only ever meant to provide a Device<Bound>, so drivers c=
ould
access device resources (such as I/O memory) to communicate with the device=
 for
teardown.
