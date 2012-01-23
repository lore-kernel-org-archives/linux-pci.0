Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1327139539-14301-7-git-send-email-yinghai@kernel.org>
References: <1327139539-14301-1-git-send-email-yinghai@kernel.org> <1327139539-14301-7-git-send-email-yinghai@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Jan 2012 08:13:59 -0800
Message-ID: <CA+55aFzP4xEbcNmZ+MS0SQ3LrULzSq+dBiT_X9U-bPpR-Ukgrw@mail.gmail.com>
Subject: Re: [PATCH 6/7] pciehp: Add Disable/enable link functions
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai.lu@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 21, 2012 at 1:52 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> +
> +       retval = pciehp_readw(ctrl, PCI_EXP_LNKCTL, &lnk_ctrl);
> +       if (retval) {
> +               ctrl_err(ctrl, "Cannot read LNKCTRL register\n");
> +               return retval;
> +       }

Is there really any point at all in checking the return value of that
readw() function?

Nobody actually ever sets it. We should stop even bothering to pretend
to care. There is no return value in real life.

If the device doesn't exist or the read fails, you will never ever get
an error *anyway*. You'll likely get 0xffff, and possibly a machine
check exception. And that is unlikely to ever change - even if the
hardware were to do it, it's insane to do error checking on an
individual IO level. It causes more problems than it could possibly
ever solve - error checking has to be done at a different level than
on some random individual access.

We should make the return type of pci_read_config_word() be 'void',
instead of having code like this that looks like it is careful, but in
actual fact in reality is just totally pointless.

                          Linus
