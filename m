Return-Path: <linus971@gmail.com>
Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160615184050.GA983@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <CAMxnaaU_3z6BSmSnYfi4ee=aTKm3aPyUaXds=G29wdp8O0m5Cw@mail.gmail.com>
 <20160614163703.GA31488@localhost> <CAMxnaaUQC0kyoBK1ri_AYEi=Dc_aiuiMp=kx1mFaZpsw9-D-eA@mail.gmail.com>
 <20160614202228.GA8449@localhost> <20160615184050.GA983@wunner.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Jun 2016 15:55:06 -1000
Message-ID: <CA+55aFz1TS8q9-+z+8y6y+6ogNAOup+1x7wkeKuoAeAeSQEDOg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andreas Noever <andreas.noever@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>, Huang Ying <ying.huang@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 15, 2016 at 8:40 AM, Lukas Wunner <lukas@wunner.de> wrote:
>
> So how should changes to drivers/thunderbolt/ be merged in the future?
>
> Andreas could probably send pulls directly to Linus, but I'm not sure
> what the requirements are. I believe Linus wants signed tags. The trust
> path from Linus to me is 4 hops and I've signed Andreas' key today,
> yielding a 5 hop trust path:
>
> Is there an upper limit on the acceptable length of the trust path?
> Does the key have to be signed by another maintainer?

I care not one whit about the idiotic gpg "trust path" crap.

To me, signatures are not about technicalities. I absolutely abhor all
the crazy people who think that signatures are about automatic web of
trust, and spend a lot of time on things like subkeys that expire
every six months etc (you know who you are). To me, that is just
complete gpg masturbation, and completely misses the point about
"trust".

Trust is not about the gpg signature. Trust is about the *person*. And
the gpg signature is a good and reasonable approximation of an ID. But
it's not some kind of absolute thing.

I'd much rather get an email from a current maintainer that I trust,
saying "look, there's going to be a new maintainer for this part of
the tree, and I signed his gpg keym and the fingerprint of that is
so-and-so.

Then, I'll do a "gpg --fetch-key", so that I have that particular key
in my keyring, and can verify that "ok, yes, I recognize the key that
signed it".

At no point do I start counting hops.

And if you lose your key, screw the whole crazy "key revocation
protocol". Its a joke. Most people who lost their keys will not have
any revocation key either. Just let me and others know. I'll just
remove that key from my keychain.

What makes me look at a key is "I've never seen this key before". The
most common reason is the people who do that f*cking annoying "let's
refresh signing keys every six months whether I need it or not because
I auto-expire them". Then I'll have to look at why the hell I'm
getting a signed pull request with a new key.

So don't worry about technicalities. I've pulled from people who had
not a single signature on their keychain, because they just were in
the wrong spot. I'd rather have a signed pull even then, just so that
I see that I get the pull requests from the same person each time, and
hopefully in a week (or month, or two), that key will get signatures.

Obviously, if you can get five people I know personally signing your
key, that makes me worry less about your particular identity, and
that's fine.

But the *real* trust is something that builds up over time as people
are good maintainers. It has absolutely nothing to do with gpg key
details. And that *real* trust is what matters a whole lot more than a
few random bits that just happen to be part of a pgp key.

                Linus
