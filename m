Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVBPoEinWC__9DF-oi8T-78YJRn95J=xXdL2GzNoKoCaQ@mail.gmail.com>
References: <1340736849-14875-1-git-send-email-yinghai@kernel.org>
 <1340736849-14875-2-git-send-email-yinghai@kernel.org> <CA+55aFzi7tHg=3k8Fmga8XmxFbn6tZLLV97vt67Xx_WtckQo6g@mail.gmail.com>
 <CAE9FiQVBPoEinWC__9DF-oi8T-78YJRn95J=xXdL2GzNoKoCaQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Jun 2012 13:43:54 -0700
Message-ID: <CA+55aFzUttojDJOy38N4cFyj7+XPggdrMBsd5vxHJ033eWPbpg@mail.gmail.com>
Subject: Re: [PATCH -v12 01/15] resources: Split out __allocate_resource()
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2012 at 1:33 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> You are right, please check updated one.

I think you can now also remove the "goto out" and in
__reallocate_resource() and replace it with a "return err;" instead.

But yeah, this looks fine.

             Linus
