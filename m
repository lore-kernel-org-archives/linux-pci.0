Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVTtjTsTizCjg3KE=yxbyh9Y_J4XBUo77RMLdxiUWv1gA@mail.gmail.com>
References: <1327139539-14301-1-git-send-email-yinghai@kernel.org>
 <1327139539-14301-2-git-send-email-yinghai@kernel.org> <CA+55aFz7B5ebEGKKJmvuWY+2O-6qarUj40CHASu_4EQ0KDgi_Q@mail.gmail.com>
 <CAE9FiQWbmO+FFsE06eQ=-PVNtdaTG3EsqXNXdUCxb9YxtPS8Cw@mail.gmail.com>
 <CA+55aFyok04YrmEYXLbAE2vB_944+aEJZhd5tzu6U2k0CLaN5A@mail.gmail.com>
 <CA+55aFwEbbq0yuN4mAtfDSbOE86mAWsBBz+pgBzn8_QHVk+B3g@mail.gmail.com>
 <CAE9FiQUPwvg0159-My4B+9FG0AeR=86Y5baQT5v8bSVcvGH=Hg@mail.gmail.com> <CAE9FiQVTtjTsTizCjg3KE=yxbyh9Y_J4XBUo77RMLdxiUWv1gA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Jan 2012 14:35:29 -0800
Message-ID: <CA+55aFw+wqCAiPRLmW5E9uGtY_NLsiXP5rTYbnzLVjjxKn486A@mail.gmail.com>
Subject: Re: [PATCH 1/7] PCI: Make sriov work with hotplug remove
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2012 at 12:48 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> it does not work... get lock up

Hmm. That's consistent with pci_stop_bus_device() just not removing
the device at all from the bus list. Which on the face of it would be
sane, since it's "stop", not "remove".

There's definitely something odd going on about that whole thing - not
just the confusion about "stop" vs "remove". It has that "is_added"
logic too. I have no idea what the logic of that whole thing is, it
really doesn't look sane.

                        Linus
