Return-Path: <linus971@gmail.com>
Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20161014132548.GA10744@localhost>
References: <20161013140746.GA14174@localhost> <CA+55aFxxsn1kBZDtjbvgnaDQe7LJuHg2WL049dCxRxwWnncoFg@mail.gmail.com>
 <CA+55aFw2pJ71SxFZXCKix8uVOJcZUu4YeMq+aubGa9+Op_yRXA@mail.gmail.com> <20161014132548.GA10744@localhost>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Oct 2016 11:03:48 -0700
Message-ID: <CA+55aFxF1Y5xeTMP7dwfb5X3z__Mpd_KwHipO=dkpHaNBcyLVw@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.9
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 14, 2016 at 6:25 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> I guess I've always been a little confused on what to put in the email
> vs. what should be in the tag message itself.

So I actually end up using either or *both* for my merge messages.

A lot of people put a "short and concise bulleted summary" in their
tag message, and then put more of a free-form "wall of text"
explanation in the email.

Other people just put both in the tag, and let "git request-pull" take
the tag-message as-is for the email.

Yet other people don't really use the tag at all (Bottomley, for
example, tends to have just something like "scsi-20161014" in his tag)
and then the explanation and summary in the email.

All of those options are _fine_. I don't really mind much one way or
the other. But what I don't want in *either* the tag *or* the email
message is just some automated list of all the commits.

(Except for the shortlog itself, I mean. I obviously want *that*
automated list of commits in the email, together with the expected
diffstat)

I actually think that from a first approximation, James Bottomley's
approach is a good starting point. Why? Because if you think of the
email as something that you send to me to explain why I should pull
and what I get, your email summary text is likely all I really want.

The people who put the message in the tag have often started out that
way, and then they get to the point where they just automate the pull
request thing by just writing a message _once_ (for the tag), and have
it automatically show up in the email body.

So I don't actually care much where the text is. I do want the email
itself to have the summary explanation (so that I can see what you are
talking about _before_ I even fetch the tag), but it's ok if the tag
has some extra summary detail in it, or if the tag has just the same
summary as the email, or if the tag has basically nothing at all and
ends up being used only for signing purposes.

What I *do* care about is that the explanation is an *explanation*.
For *humans*. It's an explanation for me ("Why should I pull?") but
it's also an explanation for the future ("What goes into the merge
message?").

Btw, many people explain things like expected merge conflicts etc, and
those I usually don't put in the merge message simply because they no
longer make sense after the merge is already done. So the "for me" and
"for the merge message" is not always the exact same thing, but to a
close approximation the two are often very similar.

And I do end up always editing the merge message. So in no case do I
blindly take whatever you send me. Sometimes the editing is very
minimal, sometimes I end up having to do major editing for typos or
layout or something. But there is no automated "turn the email and tag
into a merge message".

                Linus
